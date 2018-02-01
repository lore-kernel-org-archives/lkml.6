Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeBAQrK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:47:10 -0500
Received: from mail-db5eur01on0107.outbound.protection.outlook.com ([104.47.2.107]:12256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752542AbeBAQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:47:04 -0500
X-HPESVCS-Source-Ip: 10.144.210.204
Subject: Re: [PATCH] i2c-mux-reg: Delete an error message for a failed memory
 allocation in i2c_mux_reg_probe_dt()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>, York Sun <yorksun@freescale.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <7b0fcef4-d0b2-e12d-c369-ac6704e16a09@nokia.com>
Date: Thu, 1 Feb 2018 17:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(23676004)(47776003)(316002)(36756003)(110136005)(31686004)(53936002)(6346003)(83506002)(15650500001)(336011)(230700001)(58126008)(8666007)(229853002)(106466001)(68736007)(2486003)(26005)(50466002)(53546011)(65806001)(77096007)(65956001)(59450400001)(64126003)(8936002)(305945005)(97736004)(106002)(31696002)(81156014)(478600001)(54906003)(81166006)(2950100002)(86362001)(356003)(8676002)(26826003)(2906002)(65826007)(22756006)(6246003)(4326008)(15760500003)(5660300001)(76176011)(186003)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM2PR07MB0756;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT006;1:UhVew89DV/uBjlbnMl0qcN98x0tkKwWifgix8V9zXUPXUERWMIsrxl0k6UPbJh5fBfdUMgh1kU/51oz5pQjIWmpYTbWNZdm61yAyA8pg/UsIO4yVrMmsRHvZ6kv7x4iX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e578d7-5f5d-44d4-ee57-08d569936a35
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307);SRVR:AM2PR07MB0756;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0756;3:tOOSXRuZCWNF+qwUTI4BxGNmHIU8YiPO6v89MGfKTiDyGIsj7t3SThr1qR/7UNsWTmQP/6Y59PQRX+DOv+9vYOx6UTZG0CTSTZryMDNBuRsNYQ2sTALmEoKYePwYU+Ikm+eG9RNlTMYB7zIsNpf7cnvXptVWpVqMLZBd6/Dk3BjS0BTRSyaWq5NypgNiw7SP24IXEvscteSYV16Kk9AE3BAwoZtveuWfqKvis+4Wee32/GfGjFGJVVvaSJ3avcUGhGh1eECaZ25QfwYKuimmSuSVDxzBZelAFiCZ0z1Jz78XgciZGlsoO2DYvQdI9UCNcYHDEuyPnEJzfUlR0fwsYH8CN0WYXCl+ijKoX1FjEIE=;25:/DRPlBYJ3uRe4Ei/ZOmSD/ue0Mf6WE+e25QfiRup9A3nNXanLwT85zZrHYJ+uP2AfmJNiXCIft5sQb3XJdXCD9m1ZR4KU4028DCbn7o3pdQzXZZ+e4wX5Z4TOG6jFgVklrEHD75jL4Adz3VPZz4JbpsdbH+T8LWA16bircBH8FprMfvSJLDe5mZC++CK6dN4a8+0uUbSXs/OSbfighMeqv8nrDkhR0A5pePT/C237Tf4fH93o4KsfHk/H/2iPo1XIv70wI+GIlMWVu0J8r91wPXZ4BA6AKOHaq8peqY1FYcV6wSz77KQeEAehqPDo4B09vEf+XDsTXmU6ifsKodRrg==
X-MS-TrafficTypeDiagnostic: AM2PR07MB0756:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0756;31:dJcN1J90ycAT1e+uOK8tdcJ84MQj6mcx4VIPJKnwWPCW2Y3RZimkV4m/TwUWTbknPWZDtvwCyjF95NaxdtatfaOf38bbG/eTwgjqHpGDI2dCejiQ69EF0EITSMY99bXV8btatqtQfPq8slUpKdnDl6qey/tqDiRQKgNxvphy791+9EMOSMB3IBE3Jhjr7kQshESNvqBX77LB5mCPOrv/m3pMHgiHV0MC8w7fJbESAtc=;20:994LRgmt8MVlh1euU+THmTMwcPCqLrTIo/FOn4WvoqiSuC8TVxMCAgtqueuWUuuuoTy5fv9vKnWmfOFa5q3+Lea1jr31y/1NzBseHnBIpUtENxcWjRcyyxm5TsnatSadIysHzt1mv/qtWMG600hKT6LxoRC9G+AKg+2evUisbGcH/IYUdrgA495oF92Q3k+Z53mOYrGa1GqZ7+oqVtUmou+FoDw4kHbbYVjCG5g3xrcKaZsBE9p8ikcn8OLBnUsE3oCSWOt6OPpkA3L1CgSSXnra4UKdUjI/y3Q2kgatC0gg1BSuu5OUMOhzyMU1An0zbdDBSAjiHHy5XEwZe+Jf0pvBVaPewzr1OUjeO4O8vvz7T7Im/HsxQUh4ZEZC5Up+5ovQ/DCa0s5lLkesfFhGJ+SCGQD81CbTqpj+/Ep1zh29ZlFqkOACqDeWOm9/RSzMNz1Ph5pgzAwRntRvnqxkqE49ppnzixqq6plfb+ohZAiUxhfB674UJuSfv3vrmL6t4UfkPnwvWbiLus80JLJLZ4v0jCnbYFtIcIK3FH93r95zByREgeKOFAHcENSE+VmU2uytrX1K3NwjyqfTLu5WRre0xaq194c2n9Uh7XdkiVw=
X-Microsoft-Antispam-PRVS: <AM2PR07MB0756F4CAC041E1189259B28388FA0@AM2PR07MB0756.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231101)(11241501184)(806099)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM2PR07MB0756;BCL:0;PCL:0;RULEID:;SRVR:AM2PR07MB0756;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0756;4://cZR77wnEQ7sAq92eqF++PFDyRb+ClOlDSC93RipzNFJdJOI7vEAv9sLy/rQbCCKOdtrWnLxBQYvcw4fp7YwdzON0Ifo0fPSC+8gi2XOSOO3MP2AF2I41bMZUcym3ltMud++SjsLQsR1X9EKekRbz58lUwTz2EgS5XfAsFVCfX09vVH7R64ga/uliUBbv14Pef2V5lsMc8N4iJUnIDdb4nJl5cgURl+ThhoRJfnb9gxXiO/D29sVJ+JcxdcS/lR81aDdJHrG/c0mfSd95ODv+5O5ps1vmTZJ6fqRwmATBy3ZG5cyie/ulVo4PYfMUYmEz6wu5YxOQNnccS3vLlBvZthd8JOeLOAj442IlBqqns=
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTJQUjA3TUIwNzU2OzIzOm9rOCtaR3h0V0o3L205Rjh1eDNlc280NDhY?=
 =?utf-8?B?Y0ZndzJtaEVhQURkV0ZBUDQ2UzJueHBwakE5azFLRXJuZDZHaFdsVUw5Rm52?=
 =?utf-8?B?QnRVNlVSVGRUbCtUWFZhNm5hU3Q0bExxY21uaXRQNlVwanpQSnpHSy9mcWlX?=
 =?utf-8?B?cUxYT05qQ0FMV2pBa2VvZjBIS1RmN09JS0QzL1dhaHgyeWxPdXN6OUNvWkpq?=
 =?utf-8?B?L1h4YllxTUpvTnBDb3FPWkJPWlBOb24ra2p2WndsS0kycHIvQVdjUklzOW1H?=
 =?utf-8?B?REkzeDl4RnMwQUtyei9SUENRNUN5d1laVUlRSmZFNUVQdHZReXp3YmswR1NL?=
 =?utf-8?B?eFI0M1RaRWY3bFZxcUU4MXI0SEM3bEVaWlQrYWM3SlQyZDhGSlFvY1NKZlBY?=
 =?utf-8?B?d1BxUU5XZ0dIejA4N2JsRkhLVGd5T01hS1Q5OFhid1hiQWp4ckFoR2ZuRnFy?=
 =?utf-8?B?U0dpOUJib2hhU2VnV1pyUXZPekJvcDlBK012aitmY0x2MDZIRmxzMkNWQTBF?=
 =?utf-8?B?UkFab0J6T1VQUWUxR0dsa2RIUCtLYTF6NjZVVVd1YVFQcUN5bXdIeDY5d3RB?=
 =?utf-8?B?Q0NLMGVjdEowZWRNVVhVWFgrY0ZITVVhM3JIZ0cvTndRWWJYWkRuZEtHczV0?=
 =?utf-8?B?eXYzamREZ1VtcWVwTENkN293YTM1TmNnVjB5ZzhqZVlxU0QrdklxTjlEMjgy?=
 =?utf-8?B?WWFHOWlWL3lOOWYxMmN5OG1uZmZxbHljd3l1elNXc2hVVmU0Qng3bDBoM1hF?=
 =?utf-8?B?QW83ZnBvVnZ1czFpZ1pGV2dTT3RhVVhmTS9FcnhaUk9WTjZzLzJKUThEbUpr?=
 =?utf-8?B?b3RvTlFmYXdWUExVMVJvNFNyQjdFelN6aDhrMmZWV3RMVlByVThRUmhXek55?=
 =?utf-8?B?UThXYWhUYlZldzA3cWJsM21rNVdWSTdjQkpKL0ZsTFBvV2Z5dlZlQ0dNS013?=
 =?utf-8?B?M2UrWS9ZaW16OEViYmY0dFRqRVdrdm5hQStuTHE2YXhPYVcwbjBwTDU3T0lh?=
 =?utf-8?B?OXdPUGFOQTdtUm9yVzVYSk5pQ29PZGJxWmtsWGZXd04yeHdTd0E4MUc1RkVv?=
 =?utf-8?B?K1F1QWw4cjl6RVIyTWhycUtyVUVickRZcUYzeDNNSVI2OVFaSHVreVB0alVs?=
 =?utf-8?B?RTVZbkg2YWtIMGdJUGwyZkhtVFNQV3VzQWcyTUNTL3Y5STRUQUNpd0p1THQ3?=
 =?utf-8?B?WWVHT2pqaStlUFI2UUQzdks3L1N3ZXY4Y0VnTlV2QUtScFM4ODd5eUJyWGpy?=
 =?utf-8?B?dDRCbFBpdU9uZFRwejNTSmE3SlJGQmoxeGhKYVRZTXFMVEhnMmtUbEpHQ1dC?=
 =?utf-8?B?NnRLUElyMTFkYnZacDhwaWhCTUlGa1krOHBoMVBWQXNsUXhKb3ZPd3c3dnNJ?=
 =?utf-8?B?ZVpwUmQvZm9QbVFockFyQkRRaXhBSnQzRWFMTENVK2ZNSXczTWJ6cHcvdUoz?=
 =?utf-8?B?TEZDd3dHY0ZjQjVuYmR6L2pyUkMycHJBUlBQNVJwT2UyaWpvTDloNnZjOG1N?=
 =?utf-8?B?aDQzZmRKVnRVbTd0YUNrNjl1YXh1VUtyaGErTGRoRGxPamg3aU5tVW00bzNW?=
 =?utf-8?B?enRIU2VRS09VOUQzOFhGR2h0SjhFS0lBOEphNDB5Tzg1cFhQT0puS2tLZDhB?=
 =?utf-8?B?UVE0YTJpMHlNWFJFVE5oc3kxcU9UWElPU1p4L0MxZjBMZ3czNGJRbERuR1V2?=
 =?utf-8?B?eEhJV1JaWXpJc3czMlUrMWxBT1J2YnhHVWZ1cFNCaGx0SFUvYVl0VHZXRUhu?=
 =?utf-8?B?SS93OEdBRXZQNm1lUHJlZE96RlpDYloxRkRwb0tBVEFOR1p5am8yUkZOZkQ5?=
 =?utf-8?B?b3UrdDhST2ZEY3ppenRjTlVpc3RGVG9MYmpaa2lkZFRjS0E9PQ==?=
X-Microsoft-Antispam-Message-Info: v2BV63d4PX1q85LOd50N0S2sUPJoIxWRjA6ZFlN03KUPf8g2X9qaXepw+Z7bq4ek/BHy+XJB+3cpj/jGL+m1W5qA/RsYAIZImTHVzyVSJuyDGRU49TrDGrnTYQtHIkLL
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0756;6:Hj2jyBWXT0tVnGXfO0KyDDV2oq45Qboe7evsKbVi954APpnuFvniVRaZCxUYpgTbwTtmNa2X8EMqTKNurbhVIv2UgLQAYxgm46vCpLNgvjZT24Gz1ewQ9Vb1M/BcE5xuyn0YSHkP5xHYcarth58LGXKIVPewqdS8nt9Hy9fv3BYpyNKPcdF7omC1IjqLb+WXuwfYxfdALzuWnn1sCU9brk7y01RFj+2qkpcD97pg3H6oGvEvcaNDyfSMOXyL7XxMc+RieFbXyCh59MoDxw+1+jgHBOZSIqxkZ4LyKw+vjAvtuYe2sOgq2sVlEPLLPpEw7rlMHOGNE3hqzYxNntKkHsAGQRcnpFaQ5lJ1vX4JkIFmoWXU4jHRbvHH12K73Zxc;5:BH+CSaRXyYyDO4/u79NodMwfC0yL4AZjkleU3y7Cx5cyij6butC7h194cA1z5aeH25RcTpjQHtg0idPrGQLemo+/axd6fWFtzlTQOJXSb6Gl/Kl2JvwTzPoDE/IY7dVTMYBptKFdd42Y3fYbucrQnP/lzEP2AoO9Nh2SWLLqzoQ=;24:rFTbBpANWnkFOGh5W+vLHmnt9hBPEISQlqN1OrnDbdVDfKEAWfYbdswqWREtkGhBwsW6bj3F5p0jlaQisF8jtJvTBP9nOInjZrkUhgH+mLo=;7:vFmf4ReP2xm+Qt5LRJ+r2R5o0Blho55PY1TtDLdgaAwNt6OCHy70VXcVBuJRU6yjI88XyMdyEDeC3tde+VGgs2oFCpwCISEqbSrG1CHVsLLJV88EJMUGxsczMlfZ25zYAFnpjCVMjdNbCcTOgW+mSmmaR/iCNSSu/PXFFC+0DVBGcvwAnqzfBSGL736dVaDS4cI02t5b7zq46SAjUCS5TUwRL0kOfqS2r2PLQVn82H5tvKHKjnbEqPo3iOpP514V
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 16:47:00.3163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e578d7-5f5d-44d4-ee57-08d569936a35
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR07MB0756
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 17:24, SF Markus Elfring wrote:
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/i2c/muxes/i2c-mux-reg.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
> index c948e5a4cb04..f624ed64a47b 100644
> --- a/drivers/i2c/muxes/i2c-mux-reg.c
> +++ b/drivers/i2c/muxes/i2c-mux-reg.c
> @@ -127,10 +127,8 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
>  	values = devm_kzalloc(&pdev->dev,
>  			      sizeof(*mux->data.values) * mux->data.n_values,
>  			      GFP_KERNEL);
> -	if (!values) {
> -		dev_err(&pdev->dev, "Cannot allocate values array");
> +	if (!values)
>  		return -ENOMEM;
> -	}
>  
>  	for_each_child_of_node(np, child) {
>  		of_property_read_u32(child, "reg", values + i);

-- 
Best regards,
Alexander Sverdlin.
