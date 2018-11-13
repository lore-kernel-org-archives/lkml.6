Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F43E223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F43E223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKNE6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:58:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:50261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeKNE6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:58:07 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MW9TR-1fyFOQ3Ioj-00XIha; Tue, 13 Nov 2018 19:58:24 +0100
Message-ID: <1542135498.12945.20.camel@gmx.us>
Subject: Re: WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
 set_precision+0x84/0x90
From:   Qian Cai <cai@gmx.us>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Tue, 13 Nov 2018 13:58:18 -0500
In-Reply-To: <20181113172920.GI10650@smile.fi.intel.com>
References: <1542128132.12945.19.camel@gmx.us>
         <20181113172920.GI10650@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mywaXFOPIHwE6hx3FkrW3BAMGpwzeOHyYxsMeY5VoAvx6FwiCQv
 X4rWtMVfsaAsdc1tCT392P9JTpWp4FX2yS9UuGa1biMiyrL9/3cS0zreJf9PSsO0q5Ee4Rl
 dcKcCucsb5xaA7jlSn/pkXIQgRGX8/+qjz6D6CtzAIgzNhSAJBmaEDVDE4pVHEyaQihVTwv
 fM37ndKsK0000bUz7DfMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6efSR0Jb0Lk=:KyGlL5z7CQqOsTJaZku0TS
 dJVm/DWRXGju/xU9CdxUOgOee+w73uQyApePQos90d9k/WmT17xYmJ7Fopv4z33JHQb/SzD+m
 t3+xCO6ctt03PoZ97Om5p7Wl3ZPAHO1bNS4mbXhZmHG771DgsJ2y1v2GrNjAdIpaLy3ByzYGn
 uDG1UtBdz6wIS6mR/mA4L9qIkV7eZle6qkZMIyJgbjMl5Yqs4ArcGjksW7U5LPmnSFH0T/xaM
 E1uCg05e2ziIRaUdXl1VqTa9zkb3CBWTs4oqlvLj0ZYfe5HZakMBC3qGPgHFC1M4uEo2ZgvQH
 4lxry3nXQZ6i1FpwHB/x9yWVSB26b6OClYRw6EF210VyMbHtsPkL5HmHpAETAAN5Ko2nEwFQF
 N5hOFwqP5BeVuou8xFN1Xvip80kede/5FcHRf5BXTdKmuif2U0Rn/0RycKlb9j6wMDTDNxbBp
 +E2dZTmPuhPEV8J1Bonle/rWn/L6d4jloYOVgWDfQL/QdUW4hHoOrNMMLBxIWgzmpOCmvyT07
 qF7P7EbA+3DGqcaYpjd0xP3h7JcFBPuH24Ab94Df9JE8gDs30mcJdoG+4hlRmgla33GjY73MY
 El/+7wpRR8kMggwYgHVxuIf2BvSU6oQs1kxmVt/TcxCFf/egDhua6ZCHmY1cvHfwgpGoKPTrx
 /6WD6Q8lrTzDhigGfDsvZ40J8Su8l6IXk99kbh4m3XLv4toaKueh9oDxAe5wK2Qno2n9an3RL
 3VldripTIoPM1qWclfF+AvNtjDVP2GiIaSHSL/37TueovtWnSpl9MyO1osi7dnZaAxgzbq/Wp
 EW3WjikTCtsTLV3G7AxAmWAw3GExdVN3iiMZl6PVtblxa9CfXsQOSQYjhabnuO4XutkcJkVCz
 f2/txTf54L42Lu+SmF+8wsXmj048GPFKYzYe4NWOAAv1zeSOkebInm9yXd3o+d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 19:29 +0200, Andy Shevchenko wrote:
> On Tue, Nov 13, 2018 at 11:55:32AM -0500, Qian Cai wrote:
> 
> +Cc Rasmus
> 
> > Running the trinity fuzzer with a non-root user on an aarch64 server with
> > the
> > latest mainline (rc2) generated this. Is it just a false alarm to ignore?
> > 
> > [  807.847370] precision 65525 too large
> 
> It seems like someone uses -EAGAIN as a parameter to printf().
> 
> Or rather this line
> 
>   if (!fs && (request_module("fs-%.*s", len, name) == 0)) {
> 	  ...
>   }
> 
> Care to print the len and name parameters before this line?
len = 60612; name =
%d%d%d%d%d%d%s%s%s%d%s%d%d%d%s%s%s%s%s%d%s%d%s%s%s%d%s%d%d%s%s%d%s%s%d%d%s%s%s%s
%s%d%s%d%d%s%s%s%d%d%d%d%d%s%s%s%s%d%s%s%s%s%d%d%d%d%d%d%d%s%s%s%s%d%s%d%s%d%s%d
%s%s%d%s%d%s%s%s%s%d%s%d%s%s%d%d%s%s%d%s%d%s%s%d%s%d%d%s%s%s%s%d%s%s%s%s%d%d%s%s
%s%d%s%d%s%s%d%d%d%d%d%s%s%s%s%s%s%s%d%d%d%s%d%s%d%d%s%d%d%d%s%s%d%d%d%s%s%d%s%d
%s%s%s%d%d%d%s%d%s%s%d%s%d%s%s%d%s%d%d%s%d%s%s%d%s%s%s%s%s%d%s%d%d%d%s%d%d%d%d%s
%d%s%d%d%d%s%s%s%s%s%d%s%s%s%s%d%d%d%s%d%s%d%d%s%d%s%s%d%d%d%s%d%s%d%d%s%s%s%d%s
%s%d%d%d%d%d%d%d%d%d%d%s%d%s%d%s%d%d%s%d%d%s%d%s%s%s%d%d%d%d%s%s%d%d%s%d%d%d%s%d
%d%s%d%d%d%d%s%s%d%s%s%d%d%d%s%s%s%s%s%s%s%s%s%d%s%d%d%s%d%s%s%d%s%s%s%s%d%d%d%d
%s%d%s%s%d%d%d%s%d%d%d%s%s%s%s%d%d%d%s%d%s%d%s%d%d%d%d%d%d%d%d%d%d%s%s%d%d%d%s%d
%d%d%s%s%s%s%s%s%s%d%d%d%d%s%s%d%s%s%d%s%s%s%s%d%d%s%d%d%s%d%d%s%d%d%d%s%s%s%s%d
%s%s%d%s%d%s%d%s%d%d%d%d%s%d%d%d%s%d%d%d%d%s%s%d%s%s%d%d%d%s%d%s%d%d%d%d%d%d%s%d
%s%s%d%d%s%d%d%d%s%s%d%s%d%s%d%s%d%d%s%d%s%s%s%s%s%d%s%s%d%d%d%s%s%d%d%s%s%d%s%d
%s%d%s%s%s%
[  833.044728] ------------[ cut here ]------------
[  833.137184] precision 60612 too large
> 
> 
> > [  807.847449] WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
> > set_precision+0x84/0x90
> > [  807.860161] Modules linked in: cast6_generic cast_common lrw bridge 8021q
> > garp mrp stp llc dlci tcp_diag inet_diag af_key pptp gre l2tp_ppp
> > l2tp_netlink
> > l2tp_core ip6_udp_tunnel udp_tunnel pppoe pppox ppp_generic slhc crypto_user
> > ib_core nfnetlink scsi_transport_iscsi atm sctp vfat fat ghash_ce sha2_ce
> > sha256_arm64 sha1_ce ses enclosure ipmi_ssif sg ipmi_si ipmi_devintf
> > sbsa_gwdt
> > ipmi_msghandler sch_fq_codel xfs libcrc32c marvell mpt3sas mlx5_core
> > raid_class
> > hibmc_drm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm
> > drm
> > ixgbe hisi_sas_v2_hw igb hisi_sas_main libsas hns_dsaf mlxfw devlink
> > hns_enet_drv mdio i2c_designware_platform i2c_algo_bit i2c_designware_core
> > ehci_platform scsi_transport_sas hns_mdio hnae dm_mirror dm_region_hash
> > dm_log
> > dm_mod
> > [  807.927838] CPU: 26 PID: 64391 Comm: trinity-c90 Kdump: loaded Tainted:
> > G        W         4.20.0-rc2+ #16
> > [  807.937494] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
> > 06/01/2018
> > [  807.944718] pstate: 60000005 (nZCv daif -PAN -UAO)
> > [  807.949515] pc : set_precision+0x84/0x90
> > [  807.953439] lr : set_precision+0x84/0x90
> > [  807.957362] sp : ffff801e6430f6b0
> > [  807.960677] x29: ffff801e6430f6b0 x28: ffff801e6430fb10 
> > [  807.965992] x27: 0000000000000003 x26: 00000000ffffffd8 
> > [  807.971307] x25: ffff801e6430fba0 x24: ffff801e6430fb48 
> > [  807.976622] x23: ffff2000093ddfa0 x22: ffff801e6430f770 
> > [  807.981937] x21: ffff2000090eb4a6 x20: ffff801e6430f770 
> > [  807.987252] x19: 000000000000fff5 x18: 0000000000000000 
> > [  807.992569] x17: 0000000000000000 x16: 0000000000000000 
> > [  807.997884] x15: 0000000000000000 x14: 3878302031343220 
> > [  808.003201] x13: 6265783020303939 x12: ffff04000172b49c 
> > [  808.008516] x11: 1fffe4000172b49b x10: ffff04000172b49b 
> > [  808.013832] x9 : 0000000000000000 x8 : 203532353536206e 
> > [  808.019148] x7 : 6f69736963657270 x6 : 0000000041b58ab3 
> > [  808.024463] x5 : dfff200000000000 x4 : dfff200000000000 
> > [  808.029779] x3 : dfff200000000000 x2 : 65a2459128144800 
> > [  808.035093] x1 : 65a2459128144800 x0 : 0000000000000000 
> > [  808.040408] Call trace:
> > [  808.042861]  set_precision+0x84/0x90
> > [  808.046440]  vsnprintf+0x23c/0x858
> > [  808.049845]  __request_module+0x1a0/0x8b8
> > [  808.053860]  get_fs_type+0xb0/0x138
> > [  808.057351]  do_mount+0x2c4/0x13c0
> > [  808.060756]  ksys_mount+0xf4/0x110
> > [  808.064160]  __arm64_sys_mount+0x70/0x88
> > [  808.068087]  el0_svc_handler+0xd4/0x198
> > [  808.071928]  el0_svc+0x8/0xc
> > [  808.074810] irq event stamp: 347872
> > [  808.078305] hardirqs last  enabled at (347871): [<ffff2000082080e8>]
> > vprintk_emit+0x2b0/0x5c0
> > [  808.086833] hardirqs last disabled at (347872): [<ffff200008081490>]
> > do_debug_exception+0xd8/0x190
> > [  808.095795] softirqs last  enabled at (347844): [<ffff200008082210>]
> > __do_softirq+0x7c8/0x9c8
> > [  808.104325] softirqs last disabled at (347837): [<ffff20000812dbe4>]
> > irq_exit+0x25c/0x2f0
> > [  808.112502] ---[ end trace 598902d30712b79e ]---
> 
> 
