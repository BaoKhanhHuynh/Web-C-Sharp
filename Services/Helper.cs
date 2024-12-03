using System.Security.Cryptography;
using System.Text;

namespace WebApp.Services;
public static class Helper
{
    public static string Hash(string plaintext)
    {
        using HashAlgorithm algorithm = SHA512.Create();
        return Convert.ToHexString(algorithm.ComputeHash(Encoding.ASCII.GetBytes(plaintext)));
    }
    public static bool Verify(string plaintext, string hashedValue)
    {
        string computedHash = Hash(plaintext);

        return string.Equals(computedHash, hashedValue, StringComparison.OrdinalIgnoreCase);
    }
    public static string HmacSha512(string plaintext, string key)
    {
        using (HashAlgorithm algorithm = new HMACSHA512(Encoding.ASCII.GetBytes(key)))
        {
            return Convert.ToHexString(algorithm.ComputeHash(Encoding.UTF8.GetBytes(plaintext)));
        }
    }
}