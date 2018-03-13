Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeCMSyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:54:25 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:48000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbeCMSyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:54:23 -0400
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
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <3969f155-c3bf-44c5-d056-825e71d42152@amd.com>
Date: Tue, 13 Mar 2018 13:54:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:300:c0::22) To SN1PR12MB0703.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2070de1b-b8e1-4722-7bfb-08d58913d521
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0703;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;3:Qg8IK8YJrAJbgMWfyS5Cyoj+37sLtKM8aYtQiQtjK7PSWM9xlZVJRPxltBKcydiEvOYnYb9EE85pr220hJssBqJm2u6RMO2xqXqACsw1f+eeA/JBgM3UuWC+smZ6RSxCMwMOol9TArP3Xw8nvGJ/d109nHRTJlViWyNZFh79jNjgxXJK8DDtrvvopG42wsS+xdAVggHQRl9DBv3j1Jxx+riZ/uSaFXBGKzrgnpF/CbiajcSW0Gzgmy7NFUD5eXQq;25:EQ+9o/SYAAPSHfY6rMWVJNw3f8C/LFks6EgVFGBCEsi2Cw4mkRqS54KHqHdo/5CRd92YO6wW1rqs64a/difiUnA9BKnzVmXu6qsM+LRPJbf5AO2U4WhrwU/JFdV0ll4tiUIZJ+sXlsaUGNq/+jsTDBkkGmNBO/7FzW5WYSwtO8alOrGEcgQ4Xwm7/Y0ev/esv3GbXbc5qOA9FXkmvy89X2JHnCMWoUUPQpv+RlM24QP7vH17bnVCyr+y/KWVAWb9byoV2YRticsdP1HMkRtnPA6g/ZdyyVYWHRfThIZGdpJXmGt0bWbF51tEHIe/0CoYhORWTqToh0f+hat51ieDTA==;31:69LoWSHlIbbf/YYpJykeoWGFQITFUBHu6C9YrGo+m3eSpBI9NKB0x1+CR/P5zOTzPCTX/xydAurqobui8XskkqUx0Ol8JHfXT9Oj/79+hZuXGXVn0ijWDYs5016VYQOzVxb1qbmZhMLSMScbshGR9/eruv39bJNWUxVFbnM3vv1oJ3Pc8FChe4Eb+pj1vr8oLV9cnt018guGZu4tWSQD0ux7h13AxtAFgxuGXH9KL+Q=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0703:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:2kINAPdHycGnNvCa5HFTBKLFnmWz0XyQZehvzA3K+pTZSjEfi10HURaoMAH1c+S6ROWC2k9OD+9xEPIJ1FZ56q9zoIBdp0bACV1t7EhkuUR2Q8HoVXM1GXAxvhpm1ceyd/M9g7TWE48j50dE60QdDCXHyplNLR9FQCsMFnJyLCH6pfG4mpH097AU0An1i85510ZDIgS1nnxzdeqjjZpuIQ/qXbdSgL2B+d4DAFlbsYTV5pS9RVaeeKN9xeChTiNDmNPXAnxioYP6B/kCCILWV8gwpgSy2gjYk6R4gOTucPFeGpXSx0i5PE+7n8aFVXNFY12wQT3J9ifYneYQ+PtkbfHF6PztNfZ4n0j6ojQT7+Iexj0Fs+XuqWuq6chfZYxTu1iIsexoAl7wJzIisCCcPmQPvp8GnJ62EAW55bss6YR/Hpa/1CmO69x65InkqziWA5ODRK/JOPaGJ1uYQpTiyPeLTVE84v9J7Fzs2eU9pfUFMZ+J2DzcNbSBZW5ZU216;4:mZrVa+zaF77lTxBINLFW74BvqNpMHvWXueQLksOVarDWtsd+pHbdNGfbStNfIcURl/b6KYUxp7WuuuJZSa0fnpWyE+CUFlQy26qyrNluIf4T2ZLFW40Yz3Z1AL0Ot+zVPqgeUD5H4sMW/o38JvnwSNGVhut7bXM9MRSTiZrKYW7y1yYrGI7pIYNa39RWtmVD24vjh+6kxIsPOj6YmQpCrc9GcxQ2NS0TEFTiLzc0Cab8kXBqpVfGP1Y7HRL1YxNM5vu0riQH0rDi6m4M0lZtlg==
X-Microsoft-Antispam-PRVS: <SN1PR12MB070321B7AE674FB8602853E3FDD20@SN1PR12MB0703.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0703;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0703;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(189003)(199004)(52116002)(76176011)(23676004)(65806001)(7736002)(16526019)(65956001)(36756003)(67846002)(66066001)(47776003)(105586002)(68736007)(305945005)(26005)(16576012)(65826007)(64126003)(316002)(186003)(6246003)(58126008)(77096007)(2486003)(52146003)(53546011)(386003)(5660300001)(54906003)(25786009)(6916009)(3846002)(53936002)(6116002)(4326008)(8936002)(6666003)(106356001)(72206003)(39060400002)(2950100002)(31686004)(229853002)(31696002)(50466002)(86362001)(6486002)(230700001)(2906002)(8676002)(97736004)(478600001)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0703;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAzOzIzOlBKWVNSS204cTNhYS9XTk1HS0lxd1FZUVZ4?=
 =?utf-8?B?ZjBwME01Y2JaQ0VqcVlUUUptMU9rWlZTaWF0dzNMbVBEM04vMGliS0kzMUJu?=
 =?utf-8?B?Wk55VU5pRmVVQ25YMWlXY3ljWUJteU9uWnB0TWZ5aUxYY2habklQUFNhQnY0?=
 =?utf-8?B?SnlpejlsNDMyYWZIOXg1cDBhcEV2R25kSXBZOVA2SnJwQVVkM040YjBYSFB5?=
 =?utf-8?B?Zy8wOFZ1TVJOYmwyZnUwV2VSL3hKUmdWb2NEbUZEaHQ2bkY2Z0FjWVhVZVpD?=
 =?utf-8?B?eWlFK0pnZ1RPN2Jsd05JWWpXL0NWcFdxM05GZWszc3VGV0ZZcFN2YWJTanVz?=
 =?utf-8?B?c0ZaZXFXcGh3RktFQTlFbTZTNzdRZ0lQaHF3VWZ3aVM2ci9FaWVkRVBtenhL?=
 =?utf-8?B?RXVCaUNoUmxhVXNxV2pFdFZtQ3RaUHFzWHVqc2FtUXNOdTBrU3VmQ09iL3Js?=
 =?utf-8?B?dzkveENpZk92ckNGbytaTXZybkF3Q3Q5T2poZG5mUkVQclNvRERjSVZVVit1?=
 =?utf-8?B?QnQ2S0d6anVKR3NnZVluZlNIVHExa3dBbjRncmhuY0l5N0dKc3FXY05CUXQ4?=
 =?utf-8?B?cVZ5akY4Q0pOMFkyRXJtU3hvU0huK2hvWmZLeERaOWJSTVFTRjk0c2docFNT?=
 =?utf-8?B?VWEzR2tUVDVhNTFROWtMaTBvZHlYUmNmQXM2MVAyWlhIUDVnUHpINmRUSFJB?=
 =?utf-8?B?UU5xVGJuc05weVFmWE4rOUtRcFVPTThDVDVMa29kUFk0VGV6NThSaXZJL0dv?=
 =?utf-8?B?M2VvdmdFVG5NNWJzQUF0ajhXditpSGd3RzcwdVlWQmNGb00zRFk1NGlHaVdN?=
 =?utf-8?B?S21SQWZIODA0S25HallpZGtNL3ZSQ2xtU3Q1SnZwSkpIMFVXZ1JMSUNOVWQ1?=
 =?utf-8?B?K2ZBalMrTkRVb0VQVnkvcW5SUnpUaUpiRnVIazg1a3Nyc0d3SE9kZkVPVFNM?=
 =?utf-8?B?V0RNMmxxeEF3ZVdKQ3ZJZTBvOU4xQkJqQnZ4dDdKNzFBRzJUV292UGJoaEtL?=
 =?utf-8?B?Sk5NUzlCdkhkdU50VEJ6Y0FUSnFHSWsyc1Brb0VoTjVna1NqcW11MHNWQ2JB?=
 =?utf-8?B?UnVGdCtFUTBTQ2xLMmVuYVY0RmNtdTh3NkJnb2NETzkzd0RlUXZ2L3ZTL3VI?=
 =?utf-8?B?Sm9MZ2h6QVk2cDZ0UElmamFRNTF2Zmo3ZTByTndQazYwWERMSkJZaWRldzBE?=
 =?utf-8?B?RDV4UlI2VUNkS0pQaXZyclRrbnM0L25PTGFlZ3ZrYW9yZ21lNHNtZTZseVgy?=
 =?utf-8?B?dWxxMTNZTVdIZ0hwUFFTNlBQSlRYdXM1b1R3cGJlbkhzd2ZSRDhPTHFXTC8r?=
 =?utf-8?B?WUdabGVrbXFPVElLSkFFTWdZR1pwU0lTRkUvWDd3RFh2dEdRQXdEU25mVWky?=
 =?utf-8?B?aHBWd3Faa3c3d3ZlOC9OOFdoT3pIUlBvSlM3OTdzblJ2bUk3d0tpbVgvQVNl?=
 =?utf-8?B?Y2lIaVAyZjIwMmtPbDViOWdjZHFVTTNCQ0pJUE5nL0ZNRHVnY0dPb0s3MmhZ?=
 =?utf-8?B?RUFXYm5JeVM0MlhWN0VnWjlGUlpqRm1NVWN4NkxRanVmMmdBTy9iOU9PTTZH?=
 =?utf-8?B?RnZuSVdxSlFDNnMxYnZBSUVPWVBmdDZ0WGhPZDJCR2l6dEtWaDlPU1AwSW1S?=
 =?utf-8?B?RFFtNVNhSnhFZXpQUFN3SkN3TEJiNU43M0M0TEFyR2dCSHh2Rm9QL0R1aTlw?=
 =?utf-8?B?K1NNRXJQb0E2dkU0R2I0a2RtMmhuRlZyUW1wait2dFRzT3MyeTlZY0JHOHZt?=
 =?utf-8?B?Z3hnQ0JOelZ4UWRROXdOeUo5UzdHTHlFclh2b2NFaUtIUm9tQldnR1FrY0c5?=
 =?utf-8?B?eVV2Q2JwbVdDOW9lY1NZaHJ6YzNiQldNbUtRdEErdStxa0Y2emRES1VtTVYr?=
 =?utf-8?B?VXdoeWRYYUVzM3BMclJrN2UveU16VHVVRCs4T2Z3K1FTelNrMURBdlNHM0Nm?=
 =?utf-8?B?VVZtUVBCaVlnPT0=?=
X-Microsoft-Antispam-Message-Info: xZEc1bmzCBbaw6UfEC/5NfZ2jVHKoyXJ4OInMg/ZY1H/6tdg67OjZtH3O6OP89Vt3mmuPfiNQMGpaQLP2WVbFslHcdsBCuiKGgWt/5eBWhQi8fzntjunjW/M7plzzXovICY/LKzTrikjhu8meRsifzH8MpyxB4wok6/w0pdkrTrgtPs9CYc9+JpgS6LzjvpH
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;6:/AXUs7k9tzh2JrK4Rt7vr9CbhzlvdBdJT+VNoj6r7hygTDTbnIiY2RlIpwrjpmoKO6k7nm38oh1WP1hZKfLZOJeDkSLuEKsSUn2QRLEOr8g/6vytvAOj5X+K7cnym/KYG0lJ5IJJhRb2a5jSh5xB7YuvBkmJNlOzjtPvlkunO7Ou3bfOCD8Vldcj8CRECt7nj6wOQIDAv/nszW0mSxUWxYzE/YGcbwH0Bb+EzDtdL4exFLkEE/TujPGa0/4PQ7sWLyHdq4ILhjSbqHEosrl39N0yedCc94gugspM49ZUGhd7GlJ9EOh59wIqLwbfxKY33M/aos3SLNroOYOYl/4iugxmFQ6ikO+8YCT4tTMgp9E=;5:RKB/fT5YM5M+s+YvdQ+kSeVMxR8zoGgJy4bnqPlflYJBRFJqViH3hXdspQSMrS72fw/KN6qNu02N5dk57W09ldbrUK/SazlYm1h9lGZ3IEPa3OKbdZirMYFzNitn13ee+22UjcmfjibRXv5vp2seu6B5YI6PVPpHWaZktPvLJT4=;24:Q9pEPnAqzCnYk4UiAxW5yXZy2awH4TRAbTp4RlWgj92PdEly7XFVZxGn2hzmw/rP1v52Vnfzr8YPakqZrrXvyTISb3hdhPiiwENZ1d0HHBw=;7:fBLSivoYMaPJz2fv5V7l4GFHhO2yJOTztZ18xVh7fFxY0VwcNA5ufFYygNmAt2+mdrLUf1+/HQXPgUrO/5vuK36sRxb9TspWjiAtiJF6v9A6IzQX1+8YAiCiBQLjOZ4D53v8+HlxyI0eKSFVzaII9roOzKCm29pD+QpO6dLp38ceAO9vSIA/19WOVs7LTn88QyQjGtmurgIScq+1KXx0RQTT1m2Ahw6cd+B6GoWgnfn8LidGbScW7741Jd10+u6D
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:RQUH00MKJvIhMcFoKoMhBmH5he8pODk3I+Oe1SiIic5kRfliANOj7tzhY8nKGYXr4ER1GHvJSlIeghDWNsZ9QucwDi5C9r5EsctveefaiSsxX1i1WBmUe1y4N5SiHBWvZ1S6RXqOcGEb509wkqt1FuGc6rnz4oudIj5NE4dB2dui5pa0RGc/swsXZZQYHFR6TJU1NFDNHbw2p0VT5QvpTvAajTcCp4ra+spDwRlP2yrsR5pb0wdPU5iHdvsuzGw5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 18:54:20.9199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2070de1b-b8e1-4722-7bfb-08d58913d521
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 12:20 PM, Andy Shevchenko wrote:
> 
>> +               oboff += OSCNPRINTF("%02x:%02x:%x (%u / %04x)\n",
>> +                                   PCI_BUS_NUM(amd_iommu_devid),
>> +                                   PCI_SLOT(amd_iommu_devid),
>> +                                   PCI_FUNC(amd_iommu_devid),
> 
> Perhaps at some point we will have an extension to %p to print PCI BDFs.

But until then....  ;-)

>> +       if (strnchr(obuf, OBUFLEN, ':'))
>> +       {
> 
> Style

D'oh!

>> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
>> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
>> +       } else {
>> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
>> +       }
> 
> kstrtoint() ?

I see various mechanisms for this sort of thing, and simply chose one.
Am happy to use whatever is preferred.
