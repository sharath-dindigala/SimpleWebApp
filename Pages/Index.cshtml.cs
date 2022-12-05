using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace SimpleWebApp.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;
    public readonly string MachineName;

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
        MachineName = Environment.MachineName;
    }

    public void OnGet()
    {

    }
}
