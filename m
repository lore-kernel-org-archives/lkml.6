Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZo7F9dFisClPZEUkImMVT3KfReqlQg0heboOSBdhplY/GH2BOwJTXP6v4QASqYVboUY/fxx
ARC-Seal: i=1; a=rsa-sha256; t=1526989926; cv=none;
        d=google.com; s=arc-20160816;
        b=A1S7qjrGc3xYaU/vFRFm4YHfbo/G5I2/rCmz/FmeFlfR/pjKNjgSf9bX88EouoFRQr
         rjvfUzwoxpQo83cjVjgBv2WaY6ijy0Z+WeHx3JEizkKEm+ZOPTrYCTAyN4xLuShFs5gw
         Fliw7JOVI1f+En06whjnNeWiT/Ni8QWz/gVxrtYHKpP2igfN+mrdrMXUf0djWuroBPDO
         7JGJSECNrPYYte0jWe9mvr0nmp4nRFiPJb/48UMlfQBgPZPyeOVcMU9aS5TTxM2fGzIK
         tCdhAl7sUMj8d2UcALvj8ITnxZvB/70YVtlkz+96ir5rNZ282wAuflDLfrlsI7GZq6CO
         NE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=35bdJpZbzpz2DB/H6pjfJE5I+GkVHXkDO93hBnxDuwU=;
        b=eiuNG4BLhyn7xRderyqIEU9mlMY7pTDRseeApr4LAyzIJ+qvIDWnYu7CUH5xu+KITd
         F4YVq6x0BvQjkx0MrHKK2LzqWEcECQz0Ou4U/om1rxJ/N00UJeSJAqt3H5BicAUbB0g3
         mWD1+ai8UoSuGJXL32HgiN3sY3++WV2ZX+fqENY/4djyu52oHRQkkqkl2QIzsWYQv5LT
         QOygMKl4M4EuSkMwueLGIcdwuXNuUkc81cynwOCFVn+1A76stm1I67I3JGe2POZ0F8uE
         /wQtyjCiuIVcX1/fjo/GmenAYAV+v6zzZ36zmZM6JbVb/Tc5+GelUfMSeJQMrbi7y2q0
         llcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=fTgXwzhm;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.243.204 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=fTgXwzhm;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.243.204 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTfUwbZRzue3e9OyYl71oafhIgscZkA0oGi3q
  KbkvUeDEmzP2xJbLMXbejbewH6XWuRpPBmInbYCFlGV1tEYWNjnVBSt1gI2N2TMamQ4oiGicr
  4AdItgVDqqJorwdT/3t+z/P8PvO+LKk9x+SyosctuhyCzUCvoSw/JwijSFGVGwaGdFygK0xzH
  162cM21IwxX19ZFc2fOXiO41oFyrj5wEHHx6RDDjV0M0Nz34b/VXO+pywQ3eWwLd3rxHsN9dM
  jPcFONXoJ7r/YY4pZ+S9mS0SaCW0oeprbo+D7/bYbvCRXykc7DNB9Z8DL8dd8SxQ8EwwzfNNG
  B+Kv3v6T4S9/U0HxX9CuK/6x1MJVw8y3+4z828e8k9XzfQo+a/zVSsBW/qrY6TE7PbrWlLrC1
  +jbtubPcrq5Bt9RH0BpWi2cQdC3GCSWIIfh21IvkgMIhEubH+hhFaSAg2HI8FWSkgslUTrJIx
  jReD8Pz4+QRxLLZeB3MR8tkP4m/ZmDur0ZK5nW4Co7PkLI9G5sh8ONJpOAyqGtKpHkKPwax3/
  1qGWvwTvhiOb7S9wyCUNN02pSBy+FQ/+eEjBHOhxNTk2lM4hwInlCSAWNo7x8hFayH2enlFf4
  RWEwMUQrOh/j7R9NbAm5Uw9nxK4QinEcwHq5QcCHMJ4JIXgDhbXA3ukuhX4fOqTFm1fLuoH8l
  tQA6GxKUUjNCQn3/0fRRAOdB8lqRwt9Xg280yMi8Fpvg3JK1ERn9/1lBwcXQemmBVnARnP7gF
  9KfvstaGD45Q7UiqhOtk0TXG6LLWPp4icllNVvcdsFqM5Zu4ErsoiQJZtEmmKSSPU57BKWe7g
  GVCvWiKz+9GEMPs4RBr9n+A1mpzTI5975pESTLa659NlGKoTyWNYBmE0lVate6RLPoqbLaUu9
  /VQY205CtKZRljVQt2CWrWZFuICMbjnrrSS3lcDrE3BxNhWzCssmyz/GgxOoviqP8XJ0GqVQq
  bWa16LJb3f/X51AOiww6jSBXybQ63A86zaWGIFJDjHaQ8hBu4V8ptwZ5108PZ7iHBwJPZLSMz
  GZd7YHYLN/dpv/U2mv0vNK8MefJ8oL9d/b4Nodc7SN5Tz968HnSWHJAb2bOC957d7ddaO5+SG
  +78dLFnRX0M7fe3l5cFxd3fNKycShcJu0azNrtr5347uUdybZiywvOemJ/le+pZ33a5/4sQB2
  nurMmihs2GyjJIpQWki5J+Ae3kjzFQAQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-15.tower-218.messagelabs.com!1526989925!19721125!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@suse.com"
	<mhocko@suse.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "alexander.levin@verizon.com" <alexander.levin@verizon.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "colyli@suse.de"
	<colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>, Ocean HY1 He
	<hehy1@lenovo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Minchan Kim <minchan@kernel.org>, Nitin Gupta
	<ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Huaisheng Ye <yehs2007@gmail.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [External]  Re: [RFC PATCH v2 10/12] mm/zsmalloc: update usage of
 address zone modifiers
Thread-Topic: [External]  Re: [RFC PATCH v2 10/12] mm/zsmalloc: update usage
 of address zone modifiers
Thread-Index: AQHT8b9DoOXdhzUIpUaN8xeL4SalZqQ7okCA
Date: Tue, 22 May 2018 11:51:52 +0000
Message-ID: <HK2PR03MB16844D405C08B595CD682B6592940@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <1526916033-4877-11-git-send-email-yehs2007@gmail.com>
 <20180522112230.GA5412@bombadil.infradead.org>
In-Reply-To: <20180522112230.GA5412@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.65.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1507;7:Gv6g+UZR4gAA4wfoNKyEGB1AH67enTymxvG2i/SoSPXNnbtOFWks4GG9d/9DnsvIpgfJK3UztTvD9LPCwMSG9o6yhkeRz1NucVCN4LczGpt5yXnHtha/68rJvLRHNww7S4Rayd5cDliSZPt6E3jUidNDaQd8ExwPo7hIDbn2oCIx1xi6bY6W4O0ZNR+EW2PcQF096eQQHzguYpFss/ePw95xDt7TE8HS7Ef40E/FnkT5zbDQfdgKFNfXxf4asip3;20:o+KFVUxS2w/LHg30Z/ku7cTgkFdP6s/OX4+fj2c0TkWiY4T1ID7SN8pcFcUOLGDm1/aEUhU14vMx7OjDLtaR+juIfYeJt0LreGioedFUkU92oZoClwLqR+t81c/gy44D3GRxhQ3vHDU9D6RSegaQOMM+ZSUJpDFcbcUwsgHHLAnyRiZsuF4jkLuzmf8fmgVdsk0k1MF2pnGeQS5lMfPEUD2MgDghsC8X2KA5LhyA/Q4F2dbZSv4wZbWqw2GlB+62lyKkvDkulxg+Ou5uWVGm3Tc3IiuZxhctTwpsn8k4orSf1q11Alf+Rw8Flko3iOnmYWWHSQZ3uLKPXnyjCcYZjg==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1507;
x-ms-traffictypediagnostic: HK2PR03MB1507:
x-microsoft-antispam-prvs: <HK2PR03MB15070FB60C5A89659E6FF93492940@HK2PR03MB1507.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB1507;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1507;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(39850400004)(346002)(396003)(189003)(199004)(99286004)(5250100002)(4326008)(2900100001)(55016002)(14454004)(305945005)(316002)(229853002)(9686003)(6246003)(53936002)(39060400002)(7736002)(476003)(446003)(486006)(11346002)(97736004)(68736007)(3660700001)(3280700002)(2906002)(66066001)(106356001)(76176011)(7696005)(6506007)(186003)(86362001)(26005)(102836004)(105586002)(33656002)(7416002)(25786009)(74316002)(54906003)(6436002)(5660300001)(6916009)(8936002)(81166006)(6116002)(8676002)(3846002)(81156014)(478600001)(9126004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1507;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1zwijETSADsy4vpBJja+ogTp7GuZ48WW5//YWtnDW+3iNqs8md3vxqG1UnSL8CyETMdzh3jiPZAg2v/1IGCndkWWdMUOO+FCjzxZUutgj+LojMzzINsTHTijx62pBn9O7fs1IQZHsbjMqKjFFDqSeHm52txrirjw52gcMANBTJ1jJk9ACS4hKPB7nn1fuj9Q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 267c5002-eb9b-40de-6006-08d5bfda68ea
X-MS-Exchange-CrossTenant-Network-Message-Id: 267c5002-eb9b-40de-6006-08d5bfda68ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 11:51:52.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1507
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087569730678169?=
X-GMAIL-MSGID: =?utf-8?q?1601164989136672889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: owner-linux-mm@kvack.org On Behalf Of Matthew Wilcox
>=20
> On Mon, May 21, 2018 at 11:20:31PM +0800, Huaisheng Ye wrote:
> > @@ -343,7 +343,7 @@ static void destroy_cache(struct zs_pool *pool)
> >  static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gf=
p)
> >  {
> >  	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
> > -			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
> > +			gfp & ~__GFP_ZONE_MOVABLE);
> >  }
>=20
> This should be & ~GFP_ZONEMASK
>=20
> Actually, we should probably have a function to clear those bits rather
> than have every driver manipulating the gfp mask like this.  Maybe
>=20
> #define gfp_normal(gfp)		((gfp) & ~GFP_ZONEMASK)

Good idea!

>=20
> 	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
> -			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
> +			gfp_normal(gfp));


Sincerely,
Huaisheng Ye
