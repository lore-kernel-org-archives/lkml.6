Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeBXBtn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:49:43 -0500
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:26496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752095AbeBXBtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:49:39 -0500
From: Chris Mi <chrism@mellanox.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Cong Wang <xiyou.wangcong@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
 selftest
Thread-Topic: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
 selftest
Thread-Index: AQHTrQz4shszRyBeR0+YPS3iX4+W8qOyxZNg
Date: Sat, 24 Feb 2018 01:49:35 +0000
Message-ID: <VI1PR0501MB2143077CA6E5A728B8F581BAABC30@VI1PR0501MB2143.eurprd05.prod.outlook.com>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
 <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org>
 <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
 <CAM_iQpWSRe0t1Dr=7o+1ejULV=F+_Wx1v7yyw=NRBUTYttMxog@mail.gmail.com>
 <96bf4941-17c0-0796-292c-b66087f5f52e@infradead.org>
 <CAFhKne9Dyx1uvRz_9rvCq7mewAbLA5T77P21oBQfOR7JzP_1aQ@mail.gmail.com>
 <20180224011528.GA15231@bombadil.infradead.org>
In-Reply-To: <20180224011528.GA15231@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chrism@mellanox.com;
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1965;6:fudWCX4CWnVr+pocWytWYQtSmogYrvzdvXL4MMRdwg2b+maXFldCU1jHfmFvHVwH418msD6qQgXa81UGFja6D9spBmKHgpNrBMDQEZOgBWSN/7XXfhrkwV0u9scx7S+meBDrRp1obs5EnzsK2XmaxpJgtaMIz6xO5jvhxuZGw2PQJNaYdrcK8/E07ey6w7qVcb5f10zjaK6lsA2DQ2aaBPMjGnGiPXE8SS2E+k5pcrsLw5Sxb+XJh0uI/oHChxeWk3MQQuZcuK7jZEM4HXlmQH23UO10855g+3Y6liWNlyi9bAYEtd2Fq23f/9h92YrzGa27AA5qjSOgro43RKrhKm5sSq2HBvCsQlJ+QGaPxQ0rcKuEEk65jVEeoIsF8KRT;5:8d9ox+h4z6R0vXKegzNlINP+A5CagigtyYq1+Lzig3x1w7oohN2BnKd+2k52veFkOFCKe7XQyxdVrJDzAwHqsdKuWZLJ5Ef3QPpS3rXhiod1YEAjAZVvrpkdBLmly/ybVeIQ02kSnnsDFfaQtC0klbqj3Xxd9MFDB2QIP6KuYWo=;24:fb79i0mASFI1JopBsV8+fHPCxv6lQ6qpuboJWjrOrp6U+MqKPq6YIiJTUzwHlGeYU9sucUv5KJr+3+x4paDkq6lsUGsiBNSN6TftcJ5WVP4=;7:o0IQh+vB0TyB4YmjI3JpIt9/OpxYXUx85ktZB/stNphEEC24FA33e2nFWJlzDGj8zTHQBdOVKIvGGFMeNM3vx63yYvHX1cDKTt8sdf4RqonSvot+a+tSCNtaN4tMdX+b5cpCZuuWehYElOjfuXs0S1NhmJf/lI/KcJommiXcZNm1y7jvHMggkyjY9FO7jshY6qhqwxYSUC8FSFa3IctcSGFGhm+yG1luG+b7PZyBfg6SxABo0Tm/JtAcFfOI0h1x
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d183105-9baf-4712-77bc-08d57b28dba6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0501MB1965;
x-ms-traffictypediagnostic: VI1PR0501MB1965:
x-microsoft-antispam-prvs: <VI1PR0501MB1965F16BE08B56D2549AEAACABC30@VI1PR0501MB1965.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231206)(944501161)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0501MB1965;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1965;
x-forefront-prvs: 0593E261C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(13464003)(189003)(199004)(2950100002)(6916009)(54906003)(4326008)(6506007)(102836004)(186003)(9686003)(59450400001)(229853002)(6436002)(53936002)(316002)(97736004)(575784001)(86362001)(68736007)(55016002)(93886005)(76176011)(5250100002)(5890100001)(7696005)(25786009)(26005)(2900100001)(39060400002)(53546011)(99286004)(8676002)(3660700001)(105586002)(8936002)(6116002)(5660300001)(74316002)(81166006)(106356001)(81156014)(478600001)(2906002)(3846002)(6246003)(7736002)(305945005)(33656002)(66066001)(3280700002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB1965;H:VI1PR0501MB2143.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: eSwkoxK7K3RqU5MpTef1vAhaAgsdd1nWoiHSZcfPK9p/mH3zW2NKeEZKeCQ/RfoJVUBq4CBhW4srpJzyp0GCOCxBdbhizKGCAhUnKqyYLlbUTM68dYbwu/Zn6VtBG5lVtJrtvzfYY2ilVMsbG3c9kk4GpFgwzS/liuyWrGCIjMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d183105-9baf-4712-77bc-08d57b28dba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2018 01:49:35.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1965
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1O1nm0b006218

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Saturday, February 24, 2018 9:15 AM
> To: Cong Wang <xiyou.wangcong@gmail.com>; Khalid Aziz
> <khalid.aziz@oracle.com>; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: Chris Mi <chrism@mellanox.com>
> Subject: Re: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
> selftest
> 
> On Fri, Feb 23, 2018 Randy Dunlap wrote:
> > [add Matthew Wilcox; hopefully he can look/see]
> 
> Thanks, Randy.  I don't understand why nobody else thought to cc the author
> of the patch that it was bisected to ...
> 
> > On 02/23/2018 04:13 PM, Cong Wang wrote:
> > > On Fri, Feb 23, 2018 at 3:27 PM, Cong Wang
> > > <xiyou.wangcong@gmail.com>
> > wrote:
> > >> On Fri, Feb 23, 2018 at 11:00 AM, Randy Dunlap
> > >> <rdunlap@infradead.org>
> > wrote:
> > >>> On 02/23/2018 08:05 AM, Khalid Aziz wrote:
> > >>>> Same selftest does not cause panic on 4.15. git bisect pointed to
> > commit 6ce711f2750031d12cec91384ac5cfa0a485b60a ("idr: Make 1-based
> > IDRs more efficient").
> > >>>> Kernel config is attached.
> > >>
> > >> Looks like something horribly wrong with u32 key id idr...
> > >
> > > Adding a few printk's, I got:
> > >
> > > [   31.231560] requested handle = ffe00000
> > > [   31.232426] allocated handle = 0
> > > ...
> > > [   31.246475] requested handle = ffd00000
> > > [   31.247555] allocated handle = 1
> > >
> > >
> > > So the bug is here where we can't allocate a specific handle:
> > >
> > >                         err = idr_alloc_u32(&tp_c->handle_idr, ht,
> > &handle,
> > >                                             handle, GFP_KERNEL);
> > >                         if (err) {
> > >                                 kfree(ht);
> > >                                 return err;
> > >                         }
> 
> Please try this patch.  It fixes ffe00000, but there may be more things tested
> that it may not work for.
> 
> Chris Mi, what happened to that set of testcases you promised to write for
> me?
I promised to write it after the API is stabilized since you were going to change it.
I will inform the management about this new task and get back to you later.
> 
> diff --git a/lib/idr.c b/lib/idr.c
> index c98d77fcf393..10d9b8d47c33 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -36,8 +36,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,  {
>  	struct radix_tree_iter iter;
>  	void __rcu **slot;
> -	int base = idr->idr_base;
> -	int id = *nextid;
> +	unsigned int base = idr->idr_base;
> +	unsigned int id = *nextid;
> 
>  	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
>  		return -EINVAL;
To verify this patch, the following is a sanity test case:

# tc qdisc delete dev $link ingress > /dev/null 2>&1;
# tc qdisc add dev $link ingress;
# tc filter add dev $link prio 1 protocol ip handle 0x80000001 parent ffff: flower skip_hw src_mac e4:11:0:0:0:2 dst_mac e4:12:0:0:0:2 action drop;
# tc filter show dev $link parent ffff:

filter pref 1 flower chain 0
filter pref 1 flower chain 0 handle 0x80000001
  dst_mac e4:12:00:00:00:02
  src_mac e4:11:00:00:00:02
  eth_type ipv4
  skip_hw
  not_in_hw
        action order 1: gact action drop
         random type none pass val 0
         index 1 ref 1 bind 1

Please make sure the handle is the same as the user specifies.
