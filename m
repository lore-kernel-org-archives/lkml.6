Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeBZKAA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:00:00 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:12352
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752572AbeBZJ7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:59:52 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=chrism@mellanox.com;
Subject: Re: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
 selftest
To: Matthew Wilcox <willy@infradead.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
 <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org>
 <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
 <CAM_iQpWSRe0t1Dr=7o+1ejULV=F+_Wx1v7yyw=NRBUTYttMxog@mail.gmail.com>
 <96bf4941-17c0-0796-292c-b66087f5f52e@infradead.org>
 <CAFhKne9Dyx1uvRz_9rvCq7mewAbLA5T77P21oBQfOR7JzP_1aQ@mail.gmail.com>
 <20180224011528.GA15231@bombadil.infradead.org>
 <VI1PR0501MB2143077CA6E5A728B8F581BAABC30@VI1PR0501MB2143.eurprd05.prod.outlook.com>
 <20180224024641.GB15231@bombadil.infradead.org>
From: Chris Mi <chrism@mellanox.com>
Message-ID: <6698697d-e38e-de95-d925-08fb3ee4cce9@mellanox.com>
Date: Mon, 26 Feb 2018 17:59:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224024641.GB15231@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [118.201.220.138]
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To VI1PR0501MB2142.eurprd05.prod.outlook.com
 (2603:10a6:800:37::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39d528a9-9cbf-4059-5d4f-08d57cffacaf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0501MB2142;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2142;3:pwp5ozTFfzYKGC3dmCxVejZK4xNhJeTPuoPybORpakG6zTtSBmlWdEqX/8ymx4DDUL3ZyO6TWP2+ZDfkrQo2NS4oYrQGPgjcWKj//ES3ZpSse35XG7+O9Ufszrze3I9BUBLo421RIWHcki1tC3Ix1V9kD8dAIX+oMx11dgSMRlF68ud6hM7vrP7uslpYGeyf82js91yGVUUn6QIKUk/uhBDupsWq783XxGOFRqh6O11EJBEBRzTarHXwKfAyLfFI;25:qki4DB6UqzrJnAKtaa7Tk+SDKufxY+O8sZ9Zj2Auz13kT4XavWBaV9TZtus5lW477JACx8dDMwCcXdwIaqVSPLoHpso14WV4U6tN9CW9vdEPXZoONYkWLaixNe5gl6zn0/ZgDCxOW/DGVwSSGTt8f4NIDKMkZg5JTXB7/VpmHz9tu4iBFa7EIdBROZVY3ME2fD7ofMfCIv0DA+LPFC6EDj+2LFeigh1aMGy1EG6MJnY1UF17dlTxWBYUebmf3MLCVQWYjRViraiBZcbo9o+sVOZ158Bl6w5xnbbWQViTfGWbvNlsQ+f55u3LiwXNoVS/+gDTyUxIQZcjE9mxAToeTg==;31:6QM29X+SYigzZlHX/xyp2jnN7IjnwpdOXXVIXrDvtLqisBqZ86jXhZUtfNfGwORyzGT0IPSQAMacdozPyFG6mcIHwKnubyj6pF0nIU19zGN+0LJiBqAG+WIpoIryHAmaJSt/QEiy0dazfrILOstij447TvzRH2sWsHNtAnBgKxzFXxhIT8MkAhQp3lL9fMQNZJz/or6ufh1qpOOHTdAJFz/7NqkvVPZTjPDjUL1/s9Q=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2142:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2142;20:UFQO/fuOrm/9wQxJQj885WBX5grygK2xuiKduKHGp74+nXQxxyuVuPhNXnmAfcEiXne2rmrfVZ6a96o++9Nv+BeXBGkHaFfEjsJkChKEYSS+iIY2F9f7uFsmJlJ67+AFTKNW7xYbQJ5BNr4HmXgbYfeaVEbvVu4lCbV68bv2fSBZ+Syiwh0JftQiXu48/ujbRaT+rCCFOxbQuI870ZtHkl61H0yJPYgMWfrSllp1O97KTT8IJWe0UOCSXz9bdzlJ/1cpEU8pvOEK65TO5NqwGiGfPAF2YGIxa2Ux9crfrQA2RBCZ719KAAIDO4zImqOSE49wWIPLZbrfK8QABb8+lc4TCC0SYfAzmti1Bo599ditoj7tyHnmSEsiwsbanb09FX/Q2NpObBnbd/UUMOZr4jQyNzs/GloQQq5WSyZ80b2lL0PPVvWhgNHXkj8XORSCGjiWsgXkbbXmfi0gvobxcxSJ647q7L7aSsm35KYm9qiQNP2I51GbS/mm0W655q/7;4:xhbAR6CrHf6oqgeEt7v4vsIas6Rl4NohLLHYDCvZ6tYsH43BwS++GbA+1AlF/eqv+DMXRxzsxs0gK5HbnItZSiTRd+2inrN2wCFam9lkHM5/zhICyWsEP+8yfkySDItbEgR6y8Dd8QJuGtoJNjf5O7bWv+Or84sgnvENDJ43hxtyyAQ3YDZxPlPGHEIPl0s9U7OSEQefgbba0skF6/9uGDvZdQWARxZcHizGecx6/vbQZs+Ks1t2XglXZLdPTn0jeM0hBouctChdDWvUIOTFJw==
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2142EFC2A4F9895446D17E68ABC10@VI1PR0501MB2142.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0501MB2142;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2142;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(5660300001)(229853002)(97736004)(67846002)(86362001)(68736007)(8676002)(7736002)(2906002)(305945005)(2486003)(66066001)(81166006)(81156014)(65806001)(65956001)(3260700006)(4326008)(47776003)(39060400002)(16576012)(478600001)(64126003)(65826007)(93886005)(77096007)(106356001)(105586002)(186003)(16526019)(316002)(54906003)(53936002)(58126008)(31686004)(8936002)(3846002)(76176011)(59450400001)(26005)(53546011)(52116002)(25786009)(52146003)(386003)(23676004)(230700001)(36756003)(6246003)(6116002)(50466002)(6666003)(2950100002)(6486002)(31696002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2142;H:[10.12.201.153];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjIxNDI7MjM6ME9Qcm02bU5SYzFScnExdU9iRkdFWXBt?=
 =?utf-8?B?amdHSHg0TWNWcEhWWHZOUjRzMHBWMTMrOFpZMnhxQWg3UzFLd0tpeE5mOFc0?=
 =?utf-8?B?NVhWZ3c3WlB6WUNUQXU2NHlnR3Z2VHV1Q090dmJqcG93ODlHL0kwVlRnVjJF?=
 =?utf-8?B?QnNqK3pDSWdFL1FBeVpsZXNWQVl3Q3VqZVlTYWlGZERUT210ZGxwWGZlaWRr?=
 =?utf-8?B?VnAvaVoyZGxqb3JGNW1aaGdlRy9kOEgyaTVZbzJIN3lxLzdES0JTZGt4VFFI?=
 =?utf-8?B?bGlnWjNiSC9aUTRRdHl0bkwyc2dPaGVpMUpyVU9lcS9WY1JoOG9DRTNwUXgy?=
 =?utf-8?B?YXlRd0xacE9lNFJ1ZTRMbFE5N0Ntb2d5Y3pZK3NZYlJNcVd6am1PeGJSQ3VP?=
 =?utf-8?B?YUxjWkgraVdWdDFSdG43OFJqaDkrVG9LYU5RUU1IcElrVm5WMlpUQkFMdmtB?=
 =?utf-8?B?VFRadjk1SndVanZUSS9oS1JoMEk2cms4WVFicDM3cjUxN0hFdjFCa0VzZG11?=
 =?utf-8?B?eWd4NWRCZVR1VGtHUzNwb0dqbll5U0VhSTZVd0lYR21pRU1uekNPQURJalY1?=
 =?utf-8?B?dGtWaWVkelpjSVZUNlNzS3lqKzhUcExlMEtscXVReG9XUE51dmVoTWdTMkVo?=
 =?utf-8?B?d0hScml5cTBTdzFXSnVQdGxuSXdTMk1kRW44ODg0cEJObSsvY1VYNkJkV0di?=
 =?utf-8?B?Z2NJdkUvbHo4bTJuSVduWm0xR1dWOUNHZ2Q5ZWpLTWM3S2pOMW82ZG84dW5I?=
 =?utf-8?B?aStoU3JEUDdNWDJHYmpFOW5jRDFJTWNlbUU5RXpTNUllQk5oSWRyQnBMVWZu?=
 =?utf-8?B?K1dkazAyM2VrNjUwRWZicnQ3WHkzalBnZzFCdmVCb3IwQWlNS29MaDJwOC9i?=
 =?utf-8?B?ZlZQMDg5Q2JIdU14S0pGTmt1aHI4OWV3OWdDbFgzUmdpZm9wMUhxY0VLb3hU?=
 =?utf-8?B?c1M2bE5ER3hsWlZsTUd5S1J0Z0x1cnlDOWxwTHI3UmlaUEpJTUlHcGdvS0hj?=
 =?utf-8?B?VU04ciswdm9sa3BHUitRL1FOSVVBd1YrUVlkM3gveWkvNVBGdW1SNmVlSjEr?=
 =?utf-8?B?WDdCS2w0Z1pSWEg2a2NyZ1JZbmxuSzkvcmtScWFpWnJrUU4rVVlIdkZBY0xt?=
 =?utf-8?B?enNsZStidFdVZ0JGU01NTUNEMUJlMjhKMUJWaEhmWmdvT3dhbGVlZE9vNTZw?=
 =?utf-8?B?VEppd3N3b0tnZzBOUjIzOEVUaHlDc2V0eHNObzV1aXZMSnFiOGo5d0srZEd1?=
 =?utf-8?B?czAxWVpvTEJmdjdLUzYvaDRGWFZBSDBqWXk3S0d4WXd0MURDMDZNL29rMVlK?=
 =?utf-8?B?ZHlVTjNacUJ1aWsvZU42YUE2SEQycFVEL2RTVEV5Q1ExNXVoL3pVZlJGVnc4?=
 =?utf-8?B?WnIzTzVDNEVTdEY0OHd4cDlhQ0k1blVoU0pGTG0vS2paZ2hPTko2Nk9RWWVF?=
 =?utf-8?B?YVAzK0pJZ1JYTGhZVGdlTTNUQlhQYWFsa0Y4eFFreFZqOVJGOXp4ODNROG5y?=
 =?utf-8?B?cThHVTVKeE9XS1I4ZXVPdjJ4RU5ZL05kRFY5M3hZMzdDbXF6NGk4OVBrOXpp?=
 =?utf-8?B?K1pUY3hkTEtkRlJmZE1yeWtQYVdGaVlaTDRIM2tNbGdkZlQrMjJ0MUgrOWRu?=
 =?utf-8?B?U252NVFOTURJOU1RZ294dEtpYXpNYlQyUmczajEyclhDMVB5RGRpL09tUGNZ?=
 =?utf-8?B?c3EyLzVQMWowc1dPUm54UzVoK09XN1E3WDUweTRHeVh3L2p5dXhIamNKdXBC?=
 =?utf-8?B?T1VkRlpSaUlMYk5USlU1UkorN29PWnVoL2IyQzg0ZlBMbjJXUGxNblVRQzlw?=
 =?utf-8?B?UEhxVjFHT05YYzZOQXpuVzNpTmpLWW9YSXZqQXcyN0hSNGxSbk00TmV0ZzE4?=
 =?utf-8?B?a1NBc2dlK1h4RG41SWJEQVIzOVBxb21QbWlVNENwbVhSckNtQ2ZybUJlcG1T?=
 =?utf-8?B?aUVSWTV4OTZVTk8vUkp2SGx5RjdhQ1Y1aHBRRHFXRUFTZlEwTjViL1NtZWp1?=
 =?utf-8?B?enhWclhJbDFyMVhUT0NmWis0R3djd1hxUmRjcHZBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2142;6:hAGvAVtrek8nB1IM9ZDRya2mklEBM/JrrHclcSEn1d5SsvClCAMwZzVcOt7eY1saCe9RlGcd5qFO+JvDXeKYhlXrHv5GJtLWZ1WUUmAk3hPDe6fKuEmSwzr4iT/jt6x/XAk8oWhN1+6GnPaqrcpFp2q6OxYpfUUSIzug2wANNPDL7xHXHJgtLFMKLhL/n1jG2BFGghYd/VQL+z5irnWrzDk0s7C7rYM9hcbRu+Evy/u9uZbP+KV1nUdmC77MUnBXIZhewS7RMZph+b6zgmegsY3kj3z3x6JuDnC8FHGfGm1AGMTm1ZEkViqI/wbJNRC+X4YNVZT3nd68prtKUC+2MsdRkyykTQoKtuGBx4eGhfk=;5:RxgGrEBLNJzSpHsM/BECIkJYOBxPo75y87gr5VKRvWLb1W7d2jI22sKUwtdPFdb+Sq9hUbbKXfmh9Qzy9J+KLBRfwp8cijHJCDatUztHX2QkWlBUPbyUFrvOYC+hHlDMeey/QW46AOzHnwfoVeaqg8StqR1x9VPhvUZmu0l06PQ=;24:fDFX88KoAP5xt3tgVyN7Vuz+0xgY40L4lGi0s+nPNU3Bhna13SGUuCGJiDPL4XMQNZGEWyC5EempHz+J+lrHk7PW9cZGhUmsNzWzWQE2fX0=;7:bHgQBq18cZiouhlPUQ7OyRjNuG/bva2F8+rtjwdSk23kKIjdZuFTQbhhJlnHr14AlN00x0/4SXlayvW6jT65BA2P6yFbaO11g6fHaJBDq6wKPxTWPMg4qxRDkmrPnYoMQuB5BlwS4cFcvld9KgANuipOTYa5sf2arVZzyng5AATJLlTzaqm85fVSq4Bl+jIi/DlhtqZ+bnuxoxFpKGxyv4chnqV8I+595TBLXffhXuCU+sM2i2Dyi5ANmwJ0yOIm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 09:59:47.3938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d528a9-9cbf-4059-5d4f-08d57cffacaf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Sorry for the late response. I'll add the idr test cases for the new 
APIs ASAP.

Thanks,
Chris

On 2/24/2018 10:46 AM, Matthew Wilcox wrote:
> On Sat, Feb 24, 2018 at 01:49:35AM +0000, Chris Mi wrote:
>> To verify this patch, the following is a sanity test case:
>>
>> # tc qdisc delete dev $link ingress > /dev/null 2>&1;
>> # tc qdisc add dev $link ingress;
>> # tc filter add dev $link prio 1 protocol ip handle 0x80000001 parent ffff: flower skip_hw src_mac e4:11:0:0:0:2 dst_mac e4:12:0:0:0:2 action drop;
>> # tc filter show dev $link parent ffff:
>>
>> filter pref 1 flower chain 0
>> filter pref 1 flower chain 0 handle 0x80000001
> I added these tests to my local tree for now.
>
> diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
> index 44ef9eba5a7a..28d99325a32d 100644
> --- a/tools/testing/radix-tree/idr-test.c
> +++ b/tools/testing/radix-tree/idr-test.c
> @@ -178,6 +178,29 @@ void idr_get_next_test(int base)
>   	idr_destroy(&idr);
>   }
>   
> +void idr_u32_test(struct idr *idr, int base)
> +{
> +	assert(idr_is_empty(idr));
> +	idr_init_base(idr, base);
> +	u32 handle = 10;
> +	idr_alloc_u32(idr, NULL, &handle, handle, GFP_KERNEL);
> +	BUG_ON(handle != 10);
> +	idr_remove(idr, handle);
> +	assert(idr_is_empty(idr));
> +
> +	handle = 0x80000001;
> +	idr_alloc_u32(idr, NULL, &handle, handle, GFP_KERNEL);
> +	BUG_ON(handle != 0x80000001);
> +	idr_remove(idr, handle);
> +	assert(idr_is_empty(idr));
> +
> +	handle = 0xffe00000;
> +	idr_alloc_u32(idr, NULL, &handle, handle, GFP_KERNEL);
> +	BUG_ON(handle != 0xffe00000);
> +	idr_remove(idr, handle);
> +	assert(idr_is_empty(idr));
> +}
> +
>   void idr_checks(void)
>   {
>   	unsigned long i;
> @@ -248,6 +271,9 @@ void idr_checks(void)
>   	idr_get_next_test(0);
>   	idr_get_next_test(1);
>   	idr_get_next_test(4);
> +	idr_u32_test(&idr, 0);
> +	idr_u32_test(&idr, 1);
> +	idr_u32_test(&idr, 4);
>   }
>   
>   /*
