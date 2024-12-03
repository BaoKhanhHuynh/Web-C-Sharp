using WebApp.Repositories;
namespace WebApp.Models;
public class SiteProvider : BaseProvider
{
    public SiteProvider(IConfiguration configuration) : base(configuration)
    {

    }
    ProductRepository? products;
    public ProductRepository Products
        => products ??= new ProductRepository(Connection);

	MenusRepository? menus;
	public MenusRepository Menus
		=> menus ??= new MenusRepository(Connection);

    OrdersRepository? orders;
    public OrdersRepository Orders
        => orders ??= new OrdersRepository(Connection);

    OrderItemsRepository? orderitems;
    public OrderItemsRepository OrderItems
        => orderitems ??= new OrderItemsRepository(Connection);

    ServiceRepository? service;
    public ServiceRepository Service
        => service ??= new ServiceRepository(Connection);

    ClientRepository? client;
    public ClientRepository Client
        => client ??= new ClientRepository(Connection);
    MemberRepository? member;
    public MemberRepository Member 
        => member ??= new MemberRepository(Connection);

    TeamRepository? team;
    public TeamRepository Team
        => team ??= new TeamRepository(Connection);

    DashboardRepository? dashboard;
    public DashboardRepository Dashboard
        => dashboard ??= new DashboardRepository(Connection);

    VnPayRepository? vnPay;
    public VnPayRepository VnPay
        => vnPay ??= new VnPayRepository(Connection);

}