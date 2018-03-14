Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCNPZA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:25:00 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:17678
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751362AbeCNPYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:24:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
 device table entry
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
 <CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com>
 <3969f155-c3bf-44c5-d056-825e71d42152@amd.com>
 <CAHp75VcuYamhrEu=B1zeFpz6s1vGfZaMyonYK6p_Y_EJF4=4Ng@mail.gmail.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <5c84192d-8110-b06f-740d-723cd3099a42@amd.com>
Date: Wed, 14 Mar 2018 10:24:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcuYamhrEu=B1zeFpz6s1vGfZaMyonYK6p_Y_EJF4=4Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:404:13f::12) To BLUPR12MB0692.namprd12.prod.outlook.com
 (2a01:111:e400:5951::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 594a5bab-41b1-41de-6983-08d589bfba11
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;3:1Bz5p80BHg7MGo8JRhjCkhZjPEpqTwbJpMwYU3AES/Ngot8jMiaMSJWlLjfWWvKEzoYUcAjrAnyGwWHt1Bx1oIU+wvMwqJxoRGLKGnsmMC0ZCigl4I1yf3LE4QWUBFZrgtJwIo2oLQr0iw/futOpphBgBvvQYPrfuQNlwUefH1wHkGgHmIt7VW7yO44lR8t2zcnP7wJM10T0L96ZXWcUm1edAUqIWDKVam9dUtd/yJ6Is0VPyabWDVHkvwqyS2LC;25:wu2biyh+ReH24g0mruMxFOqvN1oRbQcCUhjYzTa0zEXmKOe0O98/IbDP9xPDDMIyW+vAXaFPsm4RqGM+Vx9s3nVwof+tkrGG2HgxVmbORLJXPCTL+YMHzyYk9Yqe8xUIxXW4tVJ2vSE7tn5drGa8Ka4lr2W1tKynPXbdcZDuxB8xh//7U0ZSh89lFYxOcsUJfi/LYcrhhq4GUm9ca/jpR4FNC5CMv9qmZzjQP+cZsmVPxg65yucqfZx2mat8aHeypcx/SxkRMG2any5hIEQ3T2fDQm3rgmG94ewW5M98CqPyFAqg0nR52xPPqOr3PD2+C5Tk8kXHJjsUIA/Wz0HIaw==;31:RCef1c2REb8gHQsm9bkDvH/X1Be0o09C99xWFT+Nn9jUqUosgM6pO5qweSXmTTvSvcJXrD306qLbYiRCEUz5UdM9eDE9CgObHJuxvjTKTjlPzEmVpWix5YZdYnQYuIx5Qe1f076O9EQrfoMaN/yKPv0nksL8TnV8vEdSMWILolTV1UkTnwFavvAd0Eoe5ELqB6OA03rpfvjGjIH83V/vpuPasVwXSH9VzGx21SXZ2Nk=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0692:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:baN0+O1oLM7OxWn7c1GN6TM1cc4Qw0ggYNsuS6cic+wW/aKnWzDNDSpTLMqU/Sj5MAmeUeGAG+zwv0VB27dByJNsRfDFCACYkVNTjEofEzQE4HZrTOxhGU260dDX9/zRKPQ7O3HDHphbQihonZLuqqwQB8Z2KMM5XHIUEHDngpExO4n/UUIbjlWDEIs81cjarpvWvMJhQ1VxLbVhyLlOjMx8DnXyzsWuj/OMSwWDp0sYAajdYkNT28Ft+rWY9Dv9EKqdNFmkuNVhNYVf/OMeB5V6ct30y9TYMMledTJTQ+9/Sj9jJKu0kEfEdrimHdtKcLBrw/FdZtzWjLs72GaCqKPrAbpi54NbA/kUGxqoLshFIgdhkU9nqt6b+s+E15VbXr9Be7hgVZ4zWca+s1dPHGcQQ8lPUKYdcByoIP4laM/RJ1qeSdtS8XOfblbKTKT8RTXhSYuOZqQDza+armpsWHzWTOeA+ZshD7X1zUWzt8aK1nwI7wiseTjOQLUx29EQ;4:jzhELlrNRZisc4xs0N0evn7uvyru8ByJVXtRGyFr/wwKoiGfrFX8CE3ByCcNgHmfJZdIQADimIMEByfIFMbY+KLyO1bxEiybIkd1iCuqQ7VtISrK1dhUYQWFwVgG7flvGg+9rno/fnwi6s0MTkJcVS3symYgmbAP75WtDIdlDoxHVodFWv5knT61108jMn1lJwf2D8BcrpS4v25+frEIpijLbD2ImwfLBp3lqArpm0y54lwo62BupbBMcPWIUy5FtCcfUOiLrF+XXndI4MMswIvk8mzXXFay5uGRNipftKotmdyJtIpvkG67GhpKFjEK
X-Microsoft-Antispam-PRVS: <BLUPR12MB06929DC5DE82BD3D88BBCF7DFDD10@BLUPR12MB0692.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR12MB0692;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0692;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(199004)(189003)(7736002)(6666003)(229853002)(316002)(106356001)(2950100002)(5660300001)(2906002)(65826007)(65956001)(16526019)(72206003)(305945005)(47776003)(65806001)(6116002)(39060400002)(3846002)(26005)(86362001)(53546011)(16576012)(386003)(230700001)(6486002)(66066001)(31696002)(478600001)(77096007)(105586002)(25786009)(81156014)(36756003)(6246003)(53936002)(68736007)(97736004)(4326008)(76176011)(93886005)(186003)(8676002)(81166006)(58126008)(54906003)(8936002)(64126003)(2486003)(31686004)(67846002)(50466002)(23676004)(6916009)(52116002)(52146003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0692;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkyOzIzOjFHUldPWTRGbUp5ZTdVQTBvWmJ2KzlCRDd1?=
 =?utf-8?B?dkZQTk94aDFVaFB2dVkzNDdON245QmhmOElWcVJ2Z2ozaFBlbEp6S2Nqbmht?=
 =?utf-8?B?L29seElqUFlvbUxrZW5sQnFQNXFYeWtaUEJRQ0RvWU95Y3I4dElCcmV1UEU3?=
 =?utf-8?B?NE1vM2VSOUFHbFJxdURTWGlmUHVoV2RBNVk3L21CVFozQXBUZ1czWXZDVEs4?=
 =?utf-8?B?L2N1dm5hbkwwNWdTTUZnOWRudExQcnI0WlRJNzV1QnFmLzZhWEVzYUc5eUdr?=
 =?utf-8?B?NUppSnh2M2RidS80TVBOa0NIdUZPdjhaVVlJWkdmL2hpU1FkUWlQYnRNQjU0?=
 =?utf-8?B?ZHM5SmRPMWxJWS82anQyUm94dUxsc3lUUm81MjZtam53N0dqT1RiejV3cSs0?=
 =?utf-8?B?bFRRbkpuMmQ2dzY5THZJclRQdno0aGVldHJqamROLzd6S2krajJrWDcrS2pV?=
 =?utf-8?B?Y2U1bG1ndWI2dVdGZFgydE04T0VnTTBKT0ZJcHdDTlc2N1BxYnkyUWNvVFhP?=
 =?utf-8?B?QkY1Z21CNjJES3A5a0FKRkNQZEJGTFRPY0lRQ2ZQRFNmVGZwY2F4UktoaFIx?=
 =?utf-8?B?MUxvZjY3UGJPamY2YUJHYlVUdWRlQUlXUUQ0NUc0NW1QbUVGVmxpSUp0b1Fz?=
 =?utf-8?B?M3ZodUFDMHJlT2t2ZlpQQWhJeUpqaENNUVE2RjFuQ2VvbTVEVkxLQy9TaU5M?=
 =?utf-8?B?amRZNnBtYjNSZXluSzkwZ085ejhBdGx5Rzhia09UaGszTG9EYlRBOGZpQVJZ?=
 =?utf-8?B?SGR1eFl0RGFWM3dVMko4em5YejRObkZRaVhhVkdBYURicXpMZkNPSnRtd2hI?=
 =?utf-8?B?bWVDVFREWnk0NUEvKzkyQWlPT0JQbGptQ01xQSs2ZURtVVFHaXl5S0ZoL21n?=
 =?utf-8?B?c1VhRU1Hc29yTmI1ZndoQUtzemRKT2VuRllzdG16cVZRTllCdGwzbmlxMko2?=
 =?utf-8?B?RXFEdzJxYmZNQm40NVdrOWJoUVB5VXFNeXJxcCtta0hjRW83T1lrVFVDRTJ0?=
 =?utf-8?B?UzFyUUFZSjkwTU8xaU05VGVEYVRQcC9KRUowVXpwMXN5eUpyZmRsT290ZHJ5?=
 =?utf-8?B?emhJanpwd2lLbHB5a2oxaGlpVHNtM2VGa3FQL1BtRTRYV2FuanR5N2tCVjFT?=
 =?utf-8?B?cjdlbnJWNFNSR2hzQitpeW82eWZuTWdqZTdQajRZMEZTcmNZNUQ5NlZ1clJk?=
 =?utf-8?B?cUVycEpoNG1iV08vU2ZmWm8rTCsyQkYrd2NydlVvM0t4aG1pN3dYNDA4VXZN?=
 =?utf-8?B?L3p1WUpnTW9EMUZ1SG1xMzI0dW4yQkZPR2ZHZW9KZk1Sc2FaUHU2TWllekpR?=
 =?utf-8?B?TlkzQ0VkMnh0YTJhMTlHZHV1bDRMTTFLMFIra0hzZGVqQVVoK3dqZzdWM2N2?=
 =?utf-8?B?ZVljS1ZwVXI0akNVdFArdFhITERDNkRYQytpcjV4Z0ViRjBWeVliODg2alpK?=
 =?utf-8?B?dWlCYS9aekF0TVVCbHZ2bFhUSGYxNEVsNEUwbDkwM04wWGUwL2VDZkEwcncw?=
 =?utf-8?B?bUpYL0s2SGtRdzhmNWpzbFRFMnJ1ZGkzU1dxZktnY0RCWU9jTmpDbmpNb1Yr?=
 =?utf-8?B?b0ViSzFoZ0Y1WW1kL1JPL1ZhSGNqdkc4TjF1TkJ1NitLcE9nbUEzQmxFNXZ0?=
 =?utf-8?B?V2dKN2hjWGlrZk1SMEpTOTRsYzhjNVdLZDYrQ2JqMHRyT2pQMUdMMlhrNUVV?=
 =?utf-8?B?M0xLZFErQTJaUHJUeWZyRGZFdWNabUZWVVVVSE9tYU1rRW1SYUt6dFY0bXBR?=
 =?utf-8?B?elZDdFZWRnNVMS8raWgyQ2FKK3VZNUk3SUY3d3RLaFU1Q2t4TkRKOUwxRzNj?=
 =?utf-8?B?VUR1YjJUbWRaMHRuRjVhUXRoa0NpSzRNYjdnTFRwcDdVZkN6QlBlanVia1lq?=
 =?utf-8?B?ajRYSjhCV1dpZ0haNStjamRjdEFvK25IT1AzaXNsWklvcEt5Ym16bjVIaURF?=
 =?utf-8?Q?Ngecha4nrrrtSSoqecZbQBBnmVGAp8=3D?=
X-Microsoft-Antispam-Message-Info: c0OsTyMEb5+IpEW1iXcYg5dAtIevoIyBfzZSIHCTR/ZSvlZRcH6brpfcAjUOTrTg2qfK9m1z16+v9CJL5v+YjCFCf+fseTkeQMxcRgQJ4wCWFSNFiiwBCSgn4UTCQceJFJ+VgeUIdxq1WR9u93ohgE/mxo6Ymbhip2ktn4xuiCl7B7dxKZvPGf3RV6dEarzX
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;6:A/GGKAqJH9egTaaK9MVswhNq2auM0H/+I4K+OxF5SpNtZn8jvfnpGx3p0mGHzUMgUEdYynWUHHW6iHRcJT+B5cDKYN1/H0SUJy8F9joWkyXK+YrTsMXt+BrY+8vgBKxNBxqEMsJ2RfdfoeSdYiYT8FUOYQndNa+Lz4QXuRcMSfyTaRc8uBkg7lxsA1tTb3PXLQ/iTpuAmL1w69QxT7Y0kYbRd+g/QFzL6TfQ0eeXhK0rMFlkHTOhrfyhtbA39mzhLQD8H7mQTBPYrh9ifpg0/wY4qcPRn8UT3hU/dW816sog5ZY7VEv0CrSXptTH1EdVdWQt/+/Ghw5ZiSFiAOgJMaFjkFwg2zrwRoTnJL+rsxU=;5:GdDnyTdervP9wqk5lVXo5WLfFmQ4n0eXq3YzVKzTgceKmeKs1w0THxrCWtHcDrLS9IxTfVUNSb650YvQJBVGiZuM5Tk7y4I4k7JgaV/uH8+xWoQ+x/xxPxACZaN1MXo1Y2LG1sl3or0rAX7Ixn1aVanlHSgq5EHwv1lHpY2pqlY=;24:jc1yo8KhHA6BR0Vq1hOPXEtU3yn7RTnXfIyLT+zzmKpo+BczVJyhI7UVM/RRtvApHy5+BpkxIAq4HQt9/iftPll9FlPd8L5CS1QdBnkyzBc=;7:v2nBMZk7IPBLO2AsrYK0xRaO2eju8K0kIHFE0hwhCJq3K5Obm5k//BcEDfhzy8eqQtIuKIa8a2yRRmM0eK2T0gsfmQC20XZwknReLl24fl+DrtVwvyMQfIgefUJ/IdyaI76RPA1BlSokAkJsxNOeu/KSlnwEAbMAcGh43wK4CTHGAaalzFjrcikQm4UfN1m3pElAW4nyuBDl+VDWDgwTup7SPxAKjmIXMMr29was/ZEiS+5+HPB5nhqWEy5gcrdn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:JuxyZy5w6moENkQvRnZ/vT9Jy4CGc0QD9g/82227rxR9rMy23NeqOixWwa6TJRoGtMXL66XbvHHpdWhCxGv9Dh2X9IppwmCShh04CDco3AJXjGE0vLeqLsW5ph9Q3BEO5zWm06eCYTjP4daYY7/w8ToliJy+AW88OVXlge6Uv3XHXy0BMmOq8jD8swaFYs95FTvpYTTM1H3rl4fMc9AnBdwq9HFA/h4I/7WfV3A2xKrqZvT/HTjR7EeGtgg4iJ2u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:24:49.3442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594a5bab-41b1-41de-6983-08d589bfba11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 03:56 PM, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 8:54 PM, Gary R Hook <gary.hook@amd.com> wrote:
>> On 03/13/2018 12:20 PM, Andy Shevchenko wrote:
> 
>>>> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
>>>> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
>>>> +       } else {
>>>> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
>>>> +       }
> 
>>> kstrtoint() ?
> 
>> I see various mechanisms for this sort of thing, and simply chose one.
>> Am happy to use whatever is preferred.
> 
> sscanf() has an enormous overhead for cases like this.
> 
> simple
> 
> ret = kstrtoint();
> if (ret)
>   ... do error handling ...
> 
> 

Gotcha. Fixed.

Thanks,
Gary
