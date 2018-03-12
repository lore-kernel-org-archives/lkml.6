Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeCLWXb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:23:31 -0400
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:53660
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751282AbeCLWX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:23:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re:
 linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]:
 (warning) Possible null pointer dereference: pipe_ctx
To: David Binderman <dcb314@hotmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>
References: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30@HE1PR0802MB2331.eurprd08.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8b55ac58-ae20-7662-10bb-c446701cd67e@amd.com>
Date: Mon, 12 Mar 2018 18:23:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::35) To DM5PR1201MB0122.namprd12.prod.outlook.com
 (2603:10b6:4:55::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8d586db-51bd-44f9-cfa7-08d58867e0e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0122;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;3:enrrP2WTMW1SGNk5vFjPpEF515KJDbNBzMXoVKQQJHMnFtDPrwfLhiHgBF3Enb3n8vZXyFRrF6dwX2ACQCRaWdPMxNctAz8fKY4kgY3JlA0S19+L/oUKHaeA+MsdtXrHUkN1LqhGG0ZBAKHI6Kucda+Nyun9gHa4v9ha6Ym4tUJoh4nVnngz4mWsuPoYiZIm5Fz0wWDi2G9DUJPr8YnPloD73BSwMhZgCr8IdSWagChzAryN5B3SByIRyFvROd8U;25:kYm2D6QRocuEAiDcbHrGCaxJnYoeggRwZIjlzH5W7qJthzSMpREoPXzANCAx+5Cla+wd0Wfdiz0T+aLqtmMc7ojdsnh7+m7YmQBDUGly8eVOxZVjkeB2oHDSSL+2EW+CrIUEGDCI/PY8yc7OCCftqLvhHVpdQkaiCZluBNHQiR6sEPo9rJNjCKa7JYmp1XI/MVcFYMOo8NmfLKSiTUw8RLJXGnYbd86BMMsaCl8EtooKd2/bMCFxZ0HEmajwOn0voAqRF7jPEbfp7FIyefvn6zKYx5knZ4FpYu0jX1p2MyBaZJtCjKhTvyASTs7pLz97ESPMr15CsLW7ukmjpy5wOg==;31:pPw7L9rc5ESlvymT1B5tXsV3o/wwLD3u4BMav/kJ+cKcSHo58ntckymn2H56vgw6OXbYxskp+jVizR8OjyCa3pv2b2ype9gHwL24/JKUp20r2GslH/PuBY0mm2XqwwJzzoa6ANSlktFXPAHWMYcygqhyeJXAPBF7AcSfIpyxFK3UdGCqYvfN3G14Mhrl4ooqHvrSN1uhvGhkkD6wFJqiz1cgNdVSShgcYIygDdFAHHQ=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0122:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;20:T6m2JJOvUAPcGXgzx8LGt35gRsMVUm2nKnb7GshQbpuwGLGQNzm2TV6bhi2TpPnoXlLfg95EEU1+o1S3DQpAiPU2y6aENWNSW8rMsg4/TruxqM2i44zzVtBAnD78VgpDo6+Df+//xmDiWGzVBLnNMwwRfXk9CCmBIqK4h02R9MCWJ5nUQrQ/DZQ7d6+lZ7ZeJ/icym2tuJu2hbkogKumd+JdNHtFfSFu7XK3D1Zlp/MQLUTJu2c3spBG8QpkGa9ooakLfJy8O56QmsMkEUNXLfGVhJwN29dPHzvJQbMUUB35SnmI6StD8psMl/fk81dNaAGr5bIn9McbHcgK4vtGYgrhGaXZ87654GksIbbFVYMxBOIYp47rUKiAnxwIzM1idlRshZOk+kNMR2KX2hLwU9MftU8FaK6pp6SfghMWPgzFVWBnNt/v62YROZBQukSFDXfsiqYahThQORu6JVwYPHvABWcD3siC++k8OGQ1SpOaOlLRgW/cgz6ltP+JsS4b;4:FONkRnx3zGQkzA/lb7ZTPubVaJeIr9b61AaQdMdogIizxMhSNtCxxT+6tTf4zoTkqKtzoRk9lJu6bJ2u48iAGGTgWGeMJXASh0awLWiW4/eduT3/+wLBi4GRb+Mm/UscYsdcb/m5PzMm/bUhHtDl6xnEaua7ikLUFJbxedC3UyCefRInzLLF6Le7JLMrBsQMItLISx97Re+kw9A2xHcbK6gshQYXfRNb3yjDtDMudKNrnIIcmE/DekoFtZME6OCuVj24EXybqDEY18Ogi1CjjsWW4NK8aBUru4UFaaJpTb77hEf2PcQMxXWp7t7wGfpq
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01224553D5D5CED58BF20622EAD30@DM5PR1201MB0122.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR1201MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0122;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(189003)(199004)(105586002)(53546011)(58126008)(110136005)(106356001)(64126003)(478600001)(2870700001)(2906002)(50466002)(72206003)(3846002)(6116002)(16576012)(31686004)(76176011)(52146003)(23676004)(52116002)(2486003)(966005)(97736004)(386003)(68736007)(316002)(15760500003)(67846002)(26005)(2950100002)(6636002)(6666003)(65826007)(77096007)(81156014)(39060400002)(65956001)(81166006)(5660300001)(8676002)(47776003)(36756003)(8936002)(2501003)(25786009)(6306002)(16526019)(6486002)(229853002)(6246003)(65806001)(2201001)(53936002)(31696002)(86362001)(305945005)(7736002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0122;H:[172.27.230.118];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMjI7MjM6Mis3Tkl4MWNRYjQrMGM4T0xpc0xIZ3Fj?=
 =?utf-8?B?elIwSWZuSWppR21rMmVrb3dyVUhKS3puMTZVak9raFhEaXYwUVRJUnRGekYr?=
 =?utf-8?B?R210M1NTZmVtQ0NwNjVuK2h4dXhKSTQvUWJ0aHQ2a0lSLzdZeDNSV1BSdG1I?=
 =?utf-8?B?aUVjSGE4QnE1L3dpR2FLTU1TV2haUlVHbTI1N3loU2JUa0VQbGdzbmtYM0tz?=
 =?utf-8?B?QXhJbjhOTVVpSmVKWU9sRFZkR0ZOTHV6NVlLT0tsSGRualFyOXhCZGE1c1lt?=
 =?utf-8?B?V09MdUhDYXRRdmxmRW9FUG9HRWVKam9zelJ6dW91eU0zWWtQcU1PTWpvNHB4?=
 =?utf-8?B?LzM2MjRiUDVseFFWWW5LcGdEbnRyeEx0VXRBNUxoZHpvVVp6MDg4bnpDUVB6?=
 =?utf-8?B?NTJrcU4zQ3ZNcmMwYzlaVGV4K1NUQmJTUnY2cXRxN3pMS3AyN0lsbWxDdjBh?=
 =?utf-8?B?UVdmbExrYXAxN1c0K2I4RkdmQXFMeTE1TmRDK1pVMnIyc2hONVJGQUxaT0ZY?=
 =?utf-8?B?U01ZeE8zbDAvWnQ3NU5yT3JLL1BjbHFXd2t5SlFvNVYzREFXTDcvSWc0bkRR?=
 =?utf-8?B?UXVGdXFhZ3AwYW5IUkpid0V1REVURzN1aDN1MC9YcHdPcVFNdGRVRDFBTTFu?=
 =?utf-8?B?dHlWaStGeWtJMmZ5a1lqYWJ4Qnp6a2ZpUWVUZXNSeFhBMU1CbDJkRWhDeWxG?=
 =?utf-8?B?bTRBSTc1Vi8zd1dDaWxPUFF2dEw3ZmlUZmIrK1MwYWFtT3F2Ylg2TjVSY2hZ?=
 =?utf-8?B?YkhYdjY2UGgxYitmeSt3cFRMOE5ZcEtxNGZTeENpL0pMZUJlaXYvTlRUMm8y?=
 =?utf-8?B?V1VEWEVNU1UzdGo1YUdaMFZCeTM3N1E0bERXWUhUZlpoRm0xaFQ4WjBTTDcw?=
 =?utf-8?B?L1lQVituOVFhSGlDcXBrcXhkLzAwY1BoanBMSEI0cHBHbU1sMEZHYWtJZk1n?=
 =?utf-8?B?SW5BMUxTR1hXZ2VMMklrbkxGWmpJM1FLTEFra2VRSUoxMEhHNmY5eWwvcHJS?=
 =?utf-8?B?YTY5Z3kzMUxWT1RSWVFTNDhrbG9tSlJlNURKb3grMWFpYmNzSzNYbDJPa042?=
 =?utf-8?B?ZE5Tc1BjcW5IU0RSMkFDWWlsdVh4SXNOL3RpWittSllhellWVVBLQWtFUTFx?=
 =?utf-8?B?RFNwcUxPcEdCd1RmU0tPTWhqYjZVSXJKaGlqdXpsaHFEWHlBUzREYm1HOFRt?=
 =?utf-8?B?ekhCTmFnU3NvU3d0ejR1ZzJOUkU4U1hvVitvcXVJTnl4K0hBZ3pRanlmd3Nv?=
 =?utf-8?B?R2VJTHZkOWc5YmNHV1VNSzhpMldEYk0wOWVsdmZEV2ZGOHJGVC9YQ0drcE1x?=
 =?utf-8?B?TnB5aTV6cUhURGxKRmhPTVZ3YVBXRjVSTmkyTGlqWDBMaTg0VzEvUHJxU0lh?=
 =?utf-8?B?V1FuTWNta3RPckE0cFJ3cWpZRUx4NWNCaUpjSUVTb0gxK2J2SUc5Ty9SU0hz?=
 =?utf-8?B?ZkUxUCtUeXZPRFlrVTlZcEp2SEFlRG1iQnhTK0FzSmdKNGR1eDQwamZPYmdU?=
 =?utf-8?B?M1Y3VWIwajdlYmxQbTBoWGlabVZmdXQ1V1UyMDQwYk1teXBvVUdWYjREbXRC?=
 =?utf-8?B?ZEQwZkFNMXpaZjRhbGhOMWR0dUhET0xpS21pWE9seXBkSnNMajl1blVhTGxT?=
 =?utf-8?B?Y1JDVTJMRFc4TVpvU3RRQW51V2Z0VTQzSjV4UzUxWHB2N0doL2NKVjZGUW1T?=
 =?utf-8?B?ekp4UWpTbUQxTzlVSnJzVVhnUFgxRmpKbmdTWjhnMnNqYWo5SGNkb05GVHEz?=
 =?utf-8?B?ZVFmY2dyaHdtZjFIU3IwQkUxVnc0d2IrcVU3U3UyR290QkFFWkF4N3l0KzBj?=
 =?utf-8?B?VzdEdVlhSTNVUkRZS3ZEaFVQa1dhMk1YM3UySDlTNkxwTVVudW1pVm05aWdG?=
 =?utf-8?B?dDNTZk5JQVRYUkR4RUcwZjhiZzRwY2l0OUQ3Y0hpelc1NmV0eFZUWXEwYVRy?=
 =?utf-8?B?WEhyQVptSkcraCtEVjl6RFh4azhsTU5HQjdVQ1RnL1RpSS9odU5NYndSU3kw?=
 =?utf-8?B?YjhpTkluTFpVWDBwYU9VWG16eEpUU2gvcTNxeEc2T1hhUm1lTTY4MDBRcVZ2?=
 =?utf-8?Q?YhpHzKRbmzi7gglbnABBhWQeAjH?=
X-Microsoft-Antispam-Message-Info: wBWA5DPNKJcWI7HgB08dwfNkShw95A/16CReJEWSuuOKC72ToW1Lm0sysRLBMtb76x2PHQ36QtZlBbB8eUAe67S29tYdT1JWMVOs9jElAETYVXPM9HGSL+fCvqWqQKzTLyidk5XK9ZliUYmVHWP95kC1ZWKQRigBGcMwCYCoQwVHd203sMXLLt72rChYjp0j
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;6:vGw4IJrQILB4xPaFkomos/BUWG/ZW1gPwl1Gq4IsOO7MlrpXyYgHvF4nhw8uasrTTnphsZZV2wHPUzUzzTMMNzJ6J8eXTuraaj3vR926Tx/U2IKDHDk/tD8ZqrMJp2vFOWZjD68LN9jNlFeIAamTgunbQfjLmrwmAdN10PeTuGJiZroRztFw+CA/J/bQ8lRuwD/DUccUzbIO4mMVJ43/XWD1X/CvoLLK9CGy3P5/BBYkhKaXUTo7XgtIZIKD/4ZSnCpuPNjepWd7ZKdHQFjZS/F5shICeSwYlpr13sMZ3lggbZ7jzoExBJocGAPfOgPO0Die0zBgubPuGWSK/x+cddhTkqi/6NG5jFiasqkKKqQ=;5:KH/SX+b5hj9XchbabOqBar1O1Lc85b4PYx2FIKFowUnwpvpMq/ttJZ88ZgAEOsBq7onD/Gl2hys+KFz5pfB3UcluQ3sDM3Cdtbf2OIyrmanjhP79sCPfC6G8rPC31KKraHwKKuRtg8D3FU/7H2Wg3MTrFq4hf2+cp9AVInLDQrM=;24:X/3Ovp5tfHnLpGKSKfagfoGl49EvDaUFsMUYYU2NDvoQ0m3zxN3IaTnmwEeJNm54ZiHEnnm6Cb338mMphBEPy8AhXoUcMkNSpFhI9OIaPdU=;7:DrmgF7jr3I2MpQQNzngydnxYUQhVSwK245s5QsVdozZbNDTj7pzPoTi3L52QpwxSSt/MVNADNr74wF6xqdczXBcOEn3e09P2zvyBsg/NubpTpqmvvJrl3hI8ozA6T3uXdD2/WjCUwH0n9Rq/DP1GSlWKXB/VMv8JT/UVactWlnchRLH7/soxDJ2lgLPcFOY018qtJMwH+BoJ/bQB9xZOmZ2o+OR+huh1TbtG27tcqbbtDzpxU9cicpDsxxNnF742
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;20:05xZgU2o6LsiI9B/mEznuI5l/4KG2SKA4PsWtR8HTFY873mUbWvFNFRjMf57vFHBusTIeT+wuAqyK7+dIjduxZDUzRbfIFrQP7QKpd7gKZCswaZqfriSTSX+SVu+Vhmwr76yBptnj87g20n5P5rjK/LoGmS/0IAYx4bE3LrTt3UC8vMsXDJUn4SyczY1kQbcWUOnjAxNjZz1SeRiGye+/FjtjNvphI5RN9D5sayj7t4oqYt68Ps51U++z/mFZ4kc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 22:23:26.8999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d586db-51bd-44f9-cfa7-08d58867e0e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2018 06:22 AM, David Binderman wrote:
> hello there,
>
> Source code is
>
>
>      for (i = 0; i < dc->res_pool->pipe_count; i++) {
>          if (res_ctx->pipe_ctx[i].stream) {
>              pipe_ctx = &res_ctx->pipe_ctx[i];
>              *pipe_idx = i;
>              break;
>          }
>      }

Indeed something like

if (!pipe_ctx)
               return false;

seems the right thing here.

Harry, Roman , your opinion ?

Andrey

>
>      /* Only supports eDP */
>      if (pipe_ctx->stream->sink->link->connector_signal != SIGNAL_TYPE_EDP)
>          return false;
>
> Suggest add some code to deal with the case that the for loop doesn't find
> what it is looking for and so pipe_ctx is NULL.
>
> Regards
>
> David Binderman
>      
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
