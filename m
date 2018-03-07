Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeCGQse (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:48:34 -0500
Received: from mail-he1eur01hn0245.outbound.protection.outlook.com ([104.47.0.245]:25600
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933468AbeCGQsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:48:30 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Wed, 7 Mar 2018 19:48:13 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
 HV_X64_MSR_VP_ASSIST_PAGE
Message-ID: <20180307164812.GA2366@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
References: <20180226171121.18974-1-vkuznets@redhat.com>
 <20180226171121.18974-2-vkuznets@redhat.com>
 <20180307161944.GE12290@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307161944.GE12290@flask>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To HE1PR0801MB1977.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e21af6a-9adc-4388-8f70-08d5844b3b75
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;3:/ul9bZZ/fo+3jeRrAqD6NlJxy0XcI/MeEDvh4LhQ5C3HC8wwIGGinX7wJNOePofZpnwLwJS6iyIW1ENYQGBu+P63h9GZ/yFiHnE/vTkn49nWVagJiOideFzeeETp1/Sbzjki/48h7M18/f/2eBKBiC966UMD0hWCl7sv3zf/BGr0anTKQ8RETWQ8EbujOi8aL/pUl69Duy3w/+aatSNLwYOdeF5dNsS37NosPUGFOtlxx1qVz+dqhpmrUq0PI2lO;25:Wc7V1h1rQ9gqZd6IecxkH+jCYTaNW4Ykn4yNfGKnxnqIT5/LgXfSqbkh2PDPOnNR2UsfEyypCRENXTwO7v2We/ZnUzGwOVdeVfbxesDlOwaY04UbDxfcBLTEh1A0Nw/ndZXJ9UsZQSAuCBvZNdvhBhVjYIwOMP2xdANUJ+LEPzI97LQTXMHfANOqr1PhjjTpB4TvC1SFCSw9B1D82gG7mirOzcwmZH9S9SlII0sF16yjRVt2lhQfO3FqJ2Bxcpvr35yXf2F86voEI7vJq5cOWyuZkcPJFMD6rMDB+Luxdyb8eWMI8K+DtZURzZUf9doXd+AcH7uo+5nVCRqpD7ifBA==;31:t9RmDnaO6Gva89GnGr2/e0yq/ofD4VZ0FFK+I3mCxtAB/tJ4976U2D2mO9ycPKhYcbqDtldqao6M9ccF5kR6cd1umjrh6WTT48a0ffF2pQus9QX2ZM3ybfBW4aeC0ZYsWG68On8QV1JBTof4FszCwBOesACOket+UhX7AI/v6S0mtPA0ssS5PMxKOcy4bSfgyzFN9Up/BKTGkaHXQMdePVB0uI7aNj6gtSaTZKeZU6A=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1977:|HE1PR0801MB1977:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;20:w+R2FIn//6xx5EwYVqsOg+GyoNsGfxQ8TDEY+yT5yclEN+2hO/Rcc6MrWv6ToK/VczSHopLFzhMoUo9vblJR+i0urkbfCzSsvlapyqM5If1f5BDs/Wqi0Nt9MTaN64ei3u97dpgxA3Kt1wbCL6WpHY33mN1W57P6bQ2EanOHmPzIJZwl8suEDR6H5uCTvEyI4e/lF/NwQ74o3KZD7xgRqbzDv1UplAD7V18Iq51fmb1dyIPVlHO8ZukrnicSIaLSdjKqldB26YAaLS45axcixShrI1M8a9AiGNl0030Zre1J4/ROKLQxeXMsWOpdaJ6isG+3ejZVPBgeOWrnVxT6/8MbwckWlUmnW1/5braqWUnAkITdO1v0RtwkChfLEdB7xaQOA++vwKPOPeR5ZsQ3MeBlCrW9NH8uWk1xDFgMxtZIEgDL89DG7RNQ/KF9xAtYU0/usbDxz3GpNRMXiKYSKp4+V+JLY3FDJcJ8L2/6o7P0GqJbf0HvQBN/jPWrMexS;4:1epcKf/e4ipUidYXG96+rfKNfUJTSWNTyRsCdgEl3LdOLt5xTO8GDaVQN7nfwLuoEPRBvV0ml1k4UHFijq/Is0plwYZMTn+70gxAcrpq9S9YJCfAT9W9/UchWsCWHZEkHmoPHMgvEE/ZqwPvhY+XJLJv9LTNB5HACgYoc4NNgxt39AIrxB/hDZlyxdMGzPDqE9ysGESc+1LcAzliJkD51Ps2fuIiItZPR37L9YygIyQO7Fq8mkfcjCeczq92st1IMUwd7oXX3AwkU0LLmZafZg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB19774EC08FC7E1DFB4C4087FC9D80@HE1PR0801MB1977.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1977;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1977;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(39850400004)(376002)(39380400002)(366004)(346002)(396003)(189003)(199004)(377424004)(52146003)(478600001)(6916009)(6666003)(6246003)(2950100002)(53416004)(7736002)(8666007)(81166006)(81156014)(86362001)(305945005)(55016002)(8936002)(66066001)(50466002)(4326008)(105586002)(7416002)(3846002)(6116002)(53936002)(1076002)(47776003)(2870700001)(97736004)(106356001)(25786009)(9686003)(5660300001)(68736007)(2906002)(54906003)(58126008)(69596002)(26005)(33656002)(186003)(316002)(229853002)(15760500003)(16526019)(7696005)(76176011)(386003)(6506007)(52116002)(23676004)(55236004)(8676002)(2486003)(36756003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1977;H:rkaganb.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjE5Nzc7MjM6elduYjY3RFY2bEhHRVZDN3QvK0RsaXN6?=
 =?utf-8?B?YStFT0Q4MEJZeXNXcmJVdUxVMXB6d2QwV3VvQmZjdHBQSmpnS0xFTVkrUFlB?=
 =?utf-8?B?VDc1SmVnSnpuRmNhaWJUQVhBdEtUSWJUWnBWRGFYSVRweGJOTmw2eFlycUtK?=
 =?utf-8?B?QS90alFGb3NnNEVNeFVKZWdjY01XOXB1TW9jU05jL2FwREN0UCtTNm4yT0cz?=
 =?utf-8?B?L09hR01Rc0pxaXhmalZOeWRrenBrTFNxVmU4YlBUbitHU3lpelc0aVpRNmVT?=
 =?utf-8?B?aGVHZzlKNjllZFAyZm15L1JaTkNxek5lRFNwUUVyMUwxbGNUQmRZWFM5dTVm?=
 =?utf-8?B?SHMwbGtxaFMzaFExVC9Ccms2d2xqMUZCcVA0MEY5aEdEdHQ1cDhDVkY1RW9l?=
 =?utf-8?B?NDdhbkZON3QvY05vYUFISGJ6bldsY0cxVnRMYkhNQ2tzZHY3a24vK0pBUTIv?=
 =?utf-8?B?RVZlNElFZlUwWW9mOVpuS0x1RlRJOTRQWktNaWFBU1pENDNrQytWdnVwalZk?=
 =?utf-8?B?UmhqamJBblYrbzhJMlpva1pDSzcyU0FsTVFVZ1FaOVg1ZEpOc3Q3RGlBUnZs?=
 =?utf-8?B?cFZpV1NlMjc0aEVHYzAvY1FjWVVHemNXMXJOdkJaRklHRDlZNExkSWxXQk9N?=
 =?utf-8?B?MVJMeUc1VGp0S3A3bTgvd1VBeksrbEkyd3I0RUdtcFA3NyszUyszTVNLd1JI?=
 =?utf-8?B?Mk5jU0hpOWU5dzRmalM1N0NhQWh1UTZONnFBaytxaXhnYndLVmJHd0llL0l2?=
 =?utf-8?B?d1EyOUdFQm1ObW9FRGx1MEgrcTQ2d3JsN2xjSUhwMFdqU1o1K3hHTm5pV0NL?=
 =?utf-8?B?bjlCNHRaSi96cVZ3a0tVZGV1L3BZbHJnT2MwbktTU3BEYUZDZ2ZXYXVjWDBL?=
 =?utf-8?B?VXg3UStXcWRZUjFhMGpqMFZzdmxtSmFRdFQ2YnlJL3RnYmc2akpnenFuaVZy?=
 =?utf-8?B?cEZpbmE4Sk9tQ0dBWjB3MkM4MU5KZlBzWlJMd0NCaERSUE1Db0tJV2loQnJU?=
 =?utf-8?B?L2Q4dFc2OGh1eGNTSEZ1T2pEbFhWNGxaczBNTGc1YkJzZmdLVlVsUVQ0UFVD?=
 =?utf-8?B?b1Y2L1B5bU4wWGpYOFV1NlpKbUhRQVh6RlBtaVFHSVczQkF3a2hSeDN6UldD?=
 =?utf-8?B?UVJUWG9RamhXbGYxL05zeGZUL3p6bmRsQlpweVo3cHB1REtxQUVVeGJqT3hn?=
 =?utf-8?B?Wk10Zjd5RkhuNzFqMXRKWGdMdHNDV3l0clUzMlJBbVg2TTRhYkdjRnloLzZF?=
 =?utf-8?B?T210VVlaMzdKVzZNdE9xYWsrcnZZM3JsZm54eUdpeS9nbEsxRmRjVXV3Qk1q?=
 =?utf-8?B?Y2dQdjNRUU1kV0VkZE1nSDh0bmpxRGFXTHluMEc3akFUOGUwd2htRU1yWEc3?=
 =?utf-8?B?U0J2d25uZEdPZ3ltR2I1ZkRtVzFIWGh2ZEhpQmFqOXg1bDFQYyt0UzViQ2VI?=
 =?utf-8?B?NzFXMG9vU1N0Q0FrQ3dhM01OaStoWjJEOUQ0VkpJOXlwQjh6NEorQUlPTDM2?=
 =?utf-8?B?Y1hQRkwvdGZ6RzAwODMvYUFhYmtzQXV0S1pzWFhGNW5mZHJFMTZWN1hHUTlH?=
 =?utf-8?B?MjUrZ2xjQzNXZzRoTTk2Q0NRdXQ1OWIrTDd2UXJiTGxVeDlQN05rMlZxejRT?=
 =?utf-8?B?cEhEbW4wbzhtVSs3K0loNStmVDllZm5tQWY3cDdsYVord1JVWERBY1JZQkFS?=
 =?utf-8?B?d0JzTzUyQU1qeFd4Y2Y2L1NTeUtDZ1RSZWVVWHdPSDhCckF3OVFjZng0ZjZ5?=
 =?utf-8?B?NjVZekZxQzFYWWpkYlRva01VZXV0Z0U0RFhrbkxwNUxIU3lFQmlZUmF6NWZW?=
 =?utf-8?B?MDJDNVdweFJFUW1Qb05IdFVYODVrVHdQalVFWGFkYXJ4bTA5WkdYVkUwRlBN?=
 =?utf-8?B?MHRwa1ZxWWp1cFRWK1pkTXJLS1l1TFdUZ2Njc29icm9PME11d0R6QjFuZHhl?=
 =?utf-8?B?Q3lETFExbmhuaDBNRkx0c0lDcjRMeEpBcjE3NGNtdUFsNWdtLzJtaThPTHJZ?=
 =?utf-8?Q?TcjRO+OS?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;23:urp6wtdKpmnd04LIaaJLYY3KLqbwiutyoZqvcAhzrkIUdMXmS+N5hudU5BJFtsycOwVJCOoFXPzMKS9FobxqCkl7xehv2bbe1FsB3RfSL48/3i9+NVXntWy7epTkZsL9OZM7NVB98xXKHVZjpo9/SQ==;6:TuCzC4P/Xuv2z2j7aHKf7K9KbTKYJGf7atnaDhEMIFesQL5L6M3WYSWXA24jr7k2V+iuuIJwB7Z6/qL8d9pwiJazcCsO9atsGpNwsMWNikvfYa8B5A0Mu2FtITav8CsQjkmnmJ98pvGHIasNiC2Ssletbu9GRV9eSBXhh809o2Rqof8KhSRBIwEIYbH0KCuV4t0oFCyaYjfTgNoirwIw00KFgh+TfKWF9WSkgDA2L3B5mrN4rNFF8IIb0gJgiSoeinFEcBzDBbuQnZXJFuIwF/7+vhDiGqFG2Yqr70RF6PcKHRFS/dRxQHKvfJAj/V0WxITL640CCVyesCJD6zubH/KQRGcH4KJkFoFm4fxbB/ElQkxI16ynW6L21th67H/8XhTH4dtFddCepuiRdkh0lw==;5:G6kB9fST2t6v/R6FTuyrnM7rr3wK22X9Y20XmoKV/R10HW3fVfQXSvAr7DFbDBwyUxKTIAGfjHhl9Dg2TZ0amW5DPzRobphSs7fvR26BH6vqYJfTrHqbDSiYZ1E9tk6VVfPk3gvU93kudZZsqSlze3SWpGK9ULCStVJ1Dur4i5I=
X-Microsoft-Antispam-Message-Info: 7vNT95Jek3W4wkbBjQeK4QcatCnAwERQm8/5QR5BlQz6KbYrgVK93c6hr0rfg9IzKhLrtVuyKAYFegmln0oePy/9cTTeb05XnJkWgOyg3z+Hh7DF7CrsoibfrKcm5pOSLCcuWtQiCu7S36Cj0IOAuHRQH5a+zCV54QJc/yZBuFwT7oZ2NgaD2JoDmfxRa9j+WGisgCyQIwzjLf6/+4jmYWFEs+wgo0peJMMuOXkwHjZoL1Hfoo4hhPoIe8SqK3vTt0l5F4BGaokQMqhNmwtJPQ==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;7:6jgU8667KKuf01Zrjk6G40jbyaMM7ELh4elyGiq7M45Ra1gGAGhmE0Q+MlJd7cztFkf4kXmu7SPN1hAVn+xFJXtAmKp2k2MVR8E67ERj3Z1Nr9nSKKc1PECi+X/vdpYKJvC54rDL8aQisDs4lJRIlXGcvWJNJvw1iolqYI1Qj9dOXp/qq3OhT9fX5lwIcHz19nsmx9G+LF+aDK2LQbJapeFM+VtTkOhrxdGgbX6TUtjLIDY4magpFZnXcSzA3dMw;20:iP/ulsL3S4xwhTs9txixL+7i3KbHJmgbhYrp0xN+3LEBIChfjG4VTjTVtecU3Weyi400Na9qEFdo7n1J9EvLBWFgyxpxR+K0Lvf4/WuTSqyCfgYgbftC7IyLUmv+rtx/RcOYFDLr2Ncq59PY9rNVWt8xUh88tmMLryt2wsF4uLY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 16:48:19.3235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e21af6a-9adc-4388-8f70-08d5844b3b75
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 05:19:44PM +0100, Radim Krčmář wrote:
> 2018-02-26 18:11+0100, Vitaly Kuznetsov:
> > From: Ladi Prosek <lprosek@redhat.com>
> > 
> > The assist page has been used only for the paravirtual EOI so far, hence
> > the "APIC" in the MSR name. Renaming to match the Hyper-V TLFS where it's
> > called "Virtual VP Assist MSR".
> > 
> > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  arch/x86/include/uapi/asm/hyperv.h | 10 +++++-----
> >  arch/x86/kvm/hyperv.c              |  8 ++++----
> >  arch/x86/kvm/lapic.h               |  2 +-
> >  arch/x86/kvm/x86.c                 |  2 +-
> >  4 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> > index 1c12aaf33915..45cc62352040 100644
> > --- a/arch/x86/include/uapi/asm/hyperv.h
> > +++ b/arch/x86/include/uapi/asm/hyperv.h
> > @@ -189,7 +189,7 @@
> >  #define HV_X64_MSR_EOI				0x40000070
> >  #define HV_X64_MSR_ICR				0x40000071
> >  #define HV_X64_MSR_TPR				0x40000072
> > -#define HV_X64_MSR_APIC_ASSIST_PAGE		0x40000073
> > +#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
> >  
> >  /* Define synthetic interrupt controller model specific registers. */
> >  #define HV_X64_MSR_SCONTROL			0x40000080
> > @@ -275,10 +275,10 @@ struct hv_tsc_emulation_status {
> >  #define HVCALL_POST_MESSAGE			0x005c
> >  #define HVCALL_SIGNAL_EVENT			0x005d
> >  
> > -#define HV_X64_MSR_APIC_ASSIST_PAGE_ENABLE		0x00000001
> > -#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT	12
> > -#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_MASK	\
> > -		(~((1ull << HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
> 
> Removing definitions from userspace api isn't a good idea.
> 
> I have no idea why hyper.h is a userspace api, though -- Linux doesn't
> define any of those, so we could copy the definitions to a private
> header, rename, and never look at this file again.

That was a thinko when it was moved to uapi, and it has already been
identified as a problem, so now QEMU has its own header with the
definitions it needs, and I'm unaware of any other userspace project
that depends on this stuff.  So I've been planning to remove it from
uapi but still haven't got around to posting the patch :(

Roman.
