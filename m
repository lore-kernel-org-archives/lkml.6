Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeDRMqD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:46:03 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:7413
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752911AbeDRMqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:46:01 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Subject: Re: [PATCH v2 1/3] ASoC: dwc: I2S Controller instance param added
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180418112442.GB10061@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <a6a4cf79-b7f7-a565-28a8-6205f8d13936@amd.com>
Date: Wed, 18 Apr 2018 18:18:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418112442.GB10061@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BMXPR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::11) To CY1PR12MB0309.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0309;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;3:VQSRBXMQeyKMiYuwikiuu6T2Zo7YJ8YzzL+Gj4SNqjpUDZPZ8t8mMXAOi2n6haWn8dVMnsM5wAwamX4iYqpSkNdRZY/zc2GpAG4bDxIDyRg4NBeZLyJSrZuS9Yzrl+A5FjT1SlPlJc8Rg2bOpcCzOpjnmHr1jW10Muyy/5y1r0Pn66qVpt82NbQq8INq3mX5VwGGvTAzNobFGYvhKDSrbWR5Y5/XqbtkV0SrPICkvPIFQFzXfZ9JZmqTH4ZoZXdN;25:4yB2a3sQOLPma3ZD3g+Pt+LnFasveZL4Hwez0BSiw9yZZEjtTnXJYkY/6SMnhTD5j+WrN/drapTvPldU9paDuK3TwK8W8s2ygRDw1NZDPGmZUmbVN57YWP8SGUTeo4kGm7QQaOab3eJ8pEtW0+xEmkma6WxxW3eI9bQ85Qei7/ZtRq11yx9vuh5Wr1X1OEXy/qWoKeSY/6WHZcjmqpegiGQCbAsFgnp2W6hx+sDndn9qGcp0HCR8eVfz/PYHRTmwjEXzHpwZynoEqed5G6vrbFoo99qb6tlCe3tRW4inRf5QP8UQFeQs4XWyCUHaP45fRxkbGPB42LvQzjLRIV6Y01fIIcurxUifJKQZMlQx0WU=;31:4dKWNzeIfHBpvwgoNGp6LAQI8JnLbLy+xuu5baDxH16BRvqZCZzJ+I1SAULz/4ju2sTX6cC+XhFKbyFqC8R2DHMLi1st5EU94INMK6se1gIBQaxPgXeVq9eKmhxOt5/RbMH8qMk92QiOSc0ib1UPbYTkuM/OWtKiQdIoN+NAOMBYCHJ/nnh8iZC86V1mZaMoLbDHILWoBwDJYBgXJSvR2fG2lt2nWV4GhODOU/V7cnc=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0309:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;20:Up6cEnaai8QDMGyduQF7z+02gZ50TjOf89IpHQp5L4jp9wyI3o1nazwbBRnuR+WFbpjD0uSzbzLU3ve9I9SGvtgLdRUTRXAoOtHkRezyNdQ5c8qjEVedJ43TkgGZMaAO7vuo1+dOiQ1ag9xKkV3syrBW7YSCGsge6nx5JbpHdt5rAOriY5c+ds5KpO+5G6K7zCJH0U9ePgwEGRwgpek3zyyj83iUN9uiAZWgOh++k7ANZgZgOp3rhFLOj5WM02C+ppjMDuUrysBlf/GdqAuiCUJbqPBQT+6bL4AjbUKzXbLKJUjVVUDwcBiYqOc9LIh5Y8Z20PBHHEiMeXNwWXc2vdvuQ1hRtSwHc/eacZtDfD8viOSD4OaKkXcRlcYpCJ5zmTkMUdmhv7uLFarsk1LkYEp9KFbakjwNAYVz1VgF2m/esBRsWv4OORgahjtDtLiMutfDidG0gSLOCF3ighj4J27clDnzBGQ6JpAWt18vgngaJxkKpL64x8PIhDMe46ly;4:K3TaLm//6vHpoqSI+A0Xo82eXeF8arhsGXdKxuOoXkrAMJhO0+otWc+jKi4h4qpxJZAXr8r/jEswDiQucKjQqEQGQfdGuXMuEYnjxQVIWttM6IA3oXmz5ZTQQLFo2TA4H7/AiPkP/qIT0LUIotl5kZ6xr6uYznV4HP/ZCFp5GvHZExFyiL8jy2y0yUAsWOvZewHGjXBT1rMWcxHsJUTW+h3v8Hz0RmHeDrpPLFCxEzpMa90gQnzlfawJVyXOCDdmpkddNDNarJRe/dAYJo8rrQ==
X-Microsoft-Antispam-PRVS: <CY1PR12MB03099166F6DFC3ABB964874297B60@CY1PR12MB0309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR12MB0309;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0309;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(376002)(366004)(396003)(39860400002)(54534003)(478600001)(25786009)(6116002)(76176011)(3846002)(11346002)(36756003)(65826007)(446003)(5660300001)(4326008)(229853002)(7736002)(186003)(16526019)(305945005)(16576012)(97736004)(72206003)(6486002)(77096007)(26005)(53936002)(23746002)(386003)(31686004)(2906002)(52116002)(316002)(50466002)(230700001)(64126003)(8676002)(58126008)(81166006)(54906003)(6246003)(31696002)(47776003)(8936002)(956004)(65806001)(67846002)(65956001)(66066001)(86362001)(6916009)(476003)(6666003)(2616005)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0309;H:[10.129.12.246];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR12MB0309;23:Uuv+cFvWbN9vpptFXnNHybbgl/8JlEyZ/DQTa?=
 =?Windows-1252?Q?vCgVhmRgSVipNhPl5auQuGXlGlFUErIHVDwKvVpCANADLdkH6CI/lHHR?=
 =?Windows-1252?Q?+7X8GJ3a0497QFmk0N8IthqVWA88nUmm2xsElXjT7TmZfvqtPICgq0Hv?=
 =?Windows-1252?Q?YRLAucIglKe9kdBLs4AVAtqPogH7uAN15J+jLlVZNKAs4hXoX0w601DR?=
 =?Windows-1252?Q?obXSgdF2ycPF1Yc8/sAbfHICFcvX3QTHAwWCdicHGp3lEY1KwhDbk8zJ?=
 =?Windows-1252?Q?P/mHY8JHugC2OnSJAFE/LLHBLGdb0Mz1Pr4EmI9G62NNz3YhI+LVanju?=
 =?Windows-1252?Q?2lwl/F9TqKY8lycCS87EEAzcl1+jABbqJwcj/2HFAIiRlFDEboPoZ/yv?=
 =?Windows-1252?Q?LI/b4X8Zy9UGqSNdd1ULvyncSDngVEzelCcdjKBCS9Uf1uwmvSVCz9vT?=
 =?Windows-1252?Q?gM5j8cxUmHq4Tpy7AEkCBC/lT6oeQZtnzAtW50e6m6ihYuL1e7pe+LsC?=
 =?Windows-1252?Q?T8e3lYfito3hT+5dE9Z8nNW6c7m4fENDH17Wgfo6HWnwF9qtH3IiREn6?=
 =?Windows-1252?Q?bPlR1B6int/sUzHGrlyLk3WVsXO7gHBkrQeLWISE/Lh5CqK51IxX/u5C?=
 =?Windows-1252?Q?y11SA5FMrXuSxN2y707ICbOhnQ0FzSYt7HJzA+Cye7xEMbpCSTvKqut+?=
 =?Windows-1252?Q?zBZ98RgQHkg5b2j1mnnlwFEVpsxdLwqWFlAJ5y22hDoavMFPawsfvSe2?=
 =?Windows-1252?Q?pcTS4zvjV6eDTGFgera38EaBb18+cW/9e9NsdacKn9ScZEcJj/HdSiY3?=
 =?Windows-1252?Q?Qowe0oDD5I3xB1WABe9CxyPH4esuFosewU9HuIEqXwwggVzbQXz4w4YR?=
 =?Windows-1252?Q?OyaY78o7LXphuHWdqrgtQcZ/anSNPpW9IYeVBhAvE4D27swZEXkBjHwx?=
 =?Windows-1252?Q?dKpEsvEhrBDkbFpIXx8pEQwuheluhetaOlXOCKjddSDJicxqSp11axYb?=
 =?Windows-1252?Q?TArshaWKEUplLUvefiAPfllv+aNCBYEKM1oFiojq4wSVCZfNYTRBwq5u?=
 =?Windows-1252?Q?Xcnq5TxhIkmOkVqyugmKYp67zMTaa0ZHWojn3dzdXmTsb9vNW/kyjqwA?=
 =?Windows-1252?Q?4rGcImk0tjLGkqooHgfGH+y0wA7aqk7fUpytH8Gx5ocSYUbTKLZOFlmi?=
 =?Windows-1252?Q?KMgrED04UPAdmxd5EPHjyjYY1oCSBxpC58ZmwW/IGrwG6C7tLzIGJyQW?=
 =?Windows-1252?Q?aip4aVTbd015XBYbLbyrs616wVzwmBpB8XHyBk/JEU9JWIdEKpVWInnj?=
 =?Windows-1252?Q?/iYgTMVw9PYg4PHSeb/guWPux0aZtKtZ8dQgyXbaEXEHYPOrnUVpiK/I?=
 =?Windows-1252?Q?522U2FIHm6bl7KKsDbLTYhOJODYIe+rVrpVUpit7RfH2PNYCTfwUOOPt?=
 =?Windows-1252?Q?MT2Kw5HAsw2nhMOU8aC?=
X-Microsoft-Antispam-Message-Info: K+EDzeS5kQLZuCMl1W7kpikJr8xWIcgsbD+ZO5rr/PiJD/he2ligO2yrqou5zTCDqv/HC8sqKjoQdS5al8vXVwufm+XRv4DYDDJKpreyoTsQ+k29H7Fyb6hmZeYEf/nW5X0mibAEPTGdB5efoTwPX2F/krm/JHqodV5xKewi6kvCsh2wBxHr85j052aP696k
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;6:4cnaYdG0fUtw/Oenzlh7JsvhjCXd8l7LJxndbX8hD6wl7C/dnkHK82O4qnR9ZsSOlbIWddsUemtDFPEFgraYBBWllEHPgn3wsc64c9OM0Fli5BOihyL8wom/a7xu7sdpAUA3oNNlb1cPa+WAc5Um3G0E/jOKQ7BmIb4qQ3yz2CQ9BpPvIKHis9q8BvrMqLwgJeWSfjkRwdWX1UEU1eR8TnTvPvUd1U6yVb/BMuyY3Jbvx00273JczQME7nXDZV4bKGKO+SbDLT2pVV4+jD5EyixHl0ae3og54uAMEpouybvvyci7PuWbnTlcOTeMesnTqNh3BT3+4asAfR2d0MmeyLt6e0lpcmWIKeYFswsG+JsaxskoZZJ+nnZWbRvhxgLnR8KM6bPY3oLMCB3r5/hTcF+44kb0PPWWscWKQIVuO73S+8n7Bhg2IoF9jVwv85MliAstZAijT9s5XSvS33V0bg==;5:a+kYrXW9JnuTQjPKMYXd8MlkzGhpwppIqQAtsZpc8k6nd1/Br4XplouHGOx7ZwQVV1H+PCGmwmLJC/WO5CZW28SATeS5tCvdazi8erKqT6/qFJ6AHfyFqb+MYmUBlaIGHnxQqnQw5962uWdLl8hUwhm8vS27oPvefpPf/LU4Xys=;24:G7cNZyAXyKmtH6S66XGXp+5xf76Q/YfZGYtnqCFUXyLBdRBiyV6PtoGyc40PWM54TIQLtlKnd65jLhKwQRxvQSpKTqC6nYe2uBgRlKrLyBc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;7:yGCIRo/R7R4/nbcz2uPPfyZAaXnzYaoaNHrhSqSSvMIrbxpxSbGnQ1exTCD/jMh6ChmBfuVNje+0hxDeiBuBfTO59STY+1AR3BOMfkEpaxSw0U+z9KiDXHVlR5r8N3GCqz+r112MIFpslMWlddJ6zKqYtP/RPdcCO92J1ee5W6Y1JyfvsFicVflowzxjxrH+k+/sfYQZ59iuMCgiB2GCQAcPtJdap6QnvktqdLXCnKwrZC6N3p+BbjMVX0PHZxzd;20:X5+f7FQFo3vZj2YRHA00gA7S/R+kfcy6YgTU9pFz/cMFXglzc4i3dwA5EfQa9eJflkc4n2eKMFPMYvTDJu/MJ80d20b2+XX99Sq8l9aEsQFw4fapf9vdECFVUm3GHQJiCyppP3fzcPP+uJ0p0AcGLKOqUWDIMzY90i2FEyc281BubjYmm3UgbzNg1U+euWEiy7wwoaBUDZLyyb64v6LfzsyCgvlQJ3Q/fr+vvglhnQ0tX2sfUEydvkozhCmbl5/J
X-MS-Office365-Filtering-Correlation-Id: 1dccf371-384c-4e7e-96fe-08d5a52a5560
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 12:45:54.7395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dccf371-384c-4e7e-96fe-08d5a52a5560
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0309
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 18 April 2018 04:54 PM, Mark Brown wrote:
> On Wed, Apr 18, 2018 at 04:34:52PM +0530, Vijendar Mukunda wrote:
>> When multiple I2S controller instances created,
>> i2s_instance parameter refers to i2s controller instance value.
> 
> You're missing the point here a bit - it's not just the defines for the
> magic numbers that are the problem, it's the whole idea of passing
> instance numbers around like this that's the big problem.  Whatever you
> are trying to do here is most likely better accomplished at the machine
> driver level.  If I'm missing something here and this is a useful
> concept to have in the driver it really needs to be articulated much
> more clearly than in your very brief changelog, and most likely done at
> the subsystem level (though the fact that we've managed to get this far
> without needing it is a bit of a red flag).
> 

In Audio Coprocessor (ACP), There are three I2S controllers can be
configured/enabled.(I2S SP, I2S MICSP, BT I2S)
Default enabled I2S controller instance is I2S SP instance.
There is a requirement to enable BT I2S controller Instance along with
I2S SP controller instance in one of our platforms Which has multiple 
codecs connected to each instance.

AMD GPU ACP driver creates devices for Playback and capture devices for 
both the I2S Controller instances using MFD framework.
Designware driver probe call gets invoked for every device creation with
resource information and platform data provided by GPU driver.

We have added one more parameter i2s instance to dwc platform data.
So that AMDGPU ACP Driver will pass I2S controller instance value to dwc 
driver while creating device nodes for I2S Controllers.

In ACP DMA Driver  acp_dma_open () call, We are retrieving dwc 
controller dev data as mentioned below.
dw_i2s_dev *dev = snd_soc_dai_get_drvdata(prtd->cpu_dai);

 From dev->i2s_instance , ACP DMA Driver gets to know current I2S 
controller instance value.
We want to make ACP DMA driver platform independent one so that it will 
work across all platforms.

This is a generic implementation. Any platform which uses Designware I2S
controller can use this implementation when multiple I2S controller
instances are created.
This patch stores the I2S controller instance value in platform data.
Please suggest us, if there is any better way to handle it.
