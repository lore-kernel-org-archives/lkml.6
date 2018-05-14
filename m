Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526286886-2-2756202059902278126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526286886; b=YKWuqFLV47sDopUYraQjR19X6cvTMIPK8UEt4Bh45DsKrDFfdK
    5XFCNRp8rZjStOiRsJCE4oLn3xLxCqr7EbRbsUWSwT9JkZWQiwpBZvNbfnjxmtjA
    5oRzyQnBqxDxwavMUfVMvipYooQd8WWbU7Ui0FhXz9Ao7dMvcIhgj0OlGZFUOFC+
    hy64pt3rp4T/0zi0G8Yq5qL9f0KPr/QjYBDVKhWsBtn3xN5g4VO3n/AAEL8k1JkV
    6LE4Wtez+FnxNvoW/IbOkw4CUD3JgbYJkcITOYRorTefDUBA1zzV1zbWQ5VGyS3d
    MDQCxXPhAk56LjCQOueIu2c8N4voIGekj2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526286886; bh=KBT0Q
    qOXbWXmSPv8sIHE/wxxne/8N3L5o53v3qrLf7E=; b=NnFakTejJ+eoSZytxAWhk
    fd84Iwi6olJukC4LAfAQlM9i6/FF/np3Kf01mP2fGTVZrmtZuN2cqo/8N2/Tw0Ji
    lDOs5jzghPTw6+T1/x/ryaLzrrh4GjwBGhuyc4iEMc5vjHsR9T4yJeuLbvEqITOt
    BabswGnpQVmwu09pJ+jpTPQK0aLEbASpaSOyxdhj7sMWI/2Ez6NBeJk5L9oeHbvP
    5FWKYOAyPHxNIbI0w9OOaEgr/8Q8Ai7QmXzQF65x4yZ9huT114G2Va1AMw6fC2YT
    hCRh63Y+xaNElGufVkIMYElI+ncJ/XrEZWJjIvEnqYlfIqMnoQ3M7L6n986mSjzr
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=bootlin.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=bootlin.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGYb0cri6SVAKSLhAXqyYdSEV+uoN2kFsXVay426QEP/m2aP8Si78xNih+lgI0b3p3B7u/bfv0DdaZwdbnM7TxKXZBmg+Wdah9cPMjzv6RglQeaUVlPx
    s7tIXSI+0hcRH8Z834nYhCCu+pXL13pmCjTlrXoVbBJ5WN5GhS26tGxhZPPXOv8VwKC33Wstl0UkUBoeR5ihSpb/BaA5eUD9+ZlAJBbGd9sNKBPFNKPas+xF
    GHTzMNZ0Au67rwrGpb7fmQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=P-IC7800AAAA:8
    a=yMhMjlubAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8
    a=ag1SF4gXAAAA:8 a=D7oJ98cEC8ze2Tdc_j4A:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=d3PnA9EDa4IxuAV0gXij:22 a=mmqRlSCDY2ywfjPLJ4af:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE
	autolearn=ham version=3.3.1
Date: Mon, 14 May 2018 10:34:28 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180514103428.55285a70@bbrezillon>
In-Reply-To: <CAMuHMdWQTOioXPmWX+_jetECpp9=SCK_BfWq9kJ7xj3WTnB_ng@mail.gmail.com>
References: <20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
	<20180510164722.GH8514@sasha-vm>
	<CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
	<CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
	<20180514101237.5df1e0d7@bbrezillon>
	<CAMuHMdWQTOioXPmWX+_jetECpp9=SCK_BfWq9kJ7xj3WTnB_ng@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 10:29:04 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Mon, May 14, 2018 at 10:12 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Mon, 14 May 2018 10:00:30 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> >> On Tue, May 1, 2018 at 10:00 PM, Sasha Levin
> >> <Alexander.Levin@microsoft.com> wrote:  
> >> > On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:  
> >> >>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:  
> >> > What's worse is that that commit is tagged for stable, which means
> >> > that (given Greg's schedule) it may find it's way to -stable users
> >> > even before some -next users/bots had a chance to test it out.  
> >>
> >> I just noticed a case where a commit was picked up for stable, while a
> >> bot had flagged it as a build regression 18 hours earlier (with a CC to
> >> lkml).  
> >
> > Also, this patch has been on a tree that I know is tested by Fengguang's
> > robots for more than a week (and in linux-next for 2 days, which, I
> > agree, is probably not enough), and still, I only received the bug
> > report when the patch reached mainline. Are there tests that are only
> > run on Linus' tree?  
> 
> Have your received a success report from Fengguang's bot, listing all
> configs tested (the broken one should be included; it is included in the
> configs tested on my branches)?

Yes I did (see below).

-->8--
From: kbuild test robot <lkp@intel.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [bbrezillon-0day:mtd/fixes] BUILD SUCCESS  fc3a9e15b492eef707afd56b7478001fdecfe53f
Date: Mon, 07 May 2018 20:05:52 +0800
User-Agent: Heirloom mailx 12.5 6/20/10

tree/branch: https://github.com/bbrezillon/linux-0day  mtd/fixes
branch HEAD: fc3a9e15b492eef707afd56b7478001fdecfe53f  mtd: rawnand: Make sure we wait tWB before polling the STATUS reg

elapsed time: 49m

configs tested: 142

The following configs have been built successfully.
More configs may be tested in the coming days.

powerpc                     skiroot_defconfig
sh                          kfr2r09_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m68k                       bvme6000_defconfig
powerpc                     ppa8548_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-05071338
i386                               tinyconfig
i386                     randconfig-n0-201818
x86_64                 randconfig-x002-201818
x86_64                 randconfig-x006-201818
x86_64                 randconfig-x005-201818
x86_64                 randconfig-x001-201818
x86_64                 randconfig-x009-201818
x86_64                 randconfig-x004-201818
x86_64                 randconfig-x003-201818
x86_64                 randconfig-x007-201818
x86_64                 randconfig-x000-201818
x86_64                 randconfig-x008-201818
i386                     randconfig-i1-201818
i386                     randconfig-i0-201818
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
ia64                                defconfig
mips                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-05071702
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
i386                     randconfig-a0-201818
i386                     randconfig-a1-201818
x86_64                 randconfig-s0-05071833
x86_64                 randconfig-s1-05071833
x86_64                 randconfig-s2-05071833
x86_64                 randconfig-s0-05071933
x86_64                 randconfig-s1-05071933
x86_64                 randconfig-s2-05071933
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201818
i386                     randconfig-s1-201818
x86_64                 randconfig-s3-05071918
x86_64                 randconfig-s4-05071918
x86_64                 randconfig-s5-05071918
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201818
i386                   randconfig-b0-05071353
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
mips                      maltaaprp_defconfig
mips                           mtx1_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-h0-05070458
i386                   randconfig-h1-05070458
x86_64                randconfig-ne0-05071525
x86_64                 randconfig-h0-05070841
i386                   randconfig-x008-201818
i386                   randconfig-x006-201818
i386                   randconfig-x000-201818
i386                   randconfig-x004-201818
i386                   randconfig-x009-201818
i386                   randconfig-x003-201818
i386                   randconfig-x001-201818
i386                   randconfig-x002-201818
i386                   randconfig-x005-201818
i386                   randconfig-x007-201818
x86_64                 randconfig-x010-201818
x86_64                 randconfig-x014-201818
x86_64                 randconfig-x013-201818
x86_64                 randconfig-x011-201818
x86_64                 randconfig-x015-201818
x86_64                 randconfig-x019-201818
x86_64                 randconfig-x016-201818
x86_64                 randconfig-x018-201818
x86_64                 randconfig-x012-201818
x86_64                 randconfig-x017-201818
i386                   randconfig-x013-201818
i386                   randconfig-x014-201818
i386                   randconfig-x019-201818
i386                   randconfig-x016-201818
i386                   randconfig-x015-201818
i386                   randconfig-x012-201818
i386                   randconfig-x018-201818
i386                   randconfig-x010-201818
i386                   randconfig-x011-201818
i386                   randconfig-x017-201818
i386                   randconfig-x073-201818
i386                   randconfig-x075-201818
i386                   randconfig-x079-201818
i386                   randconfig-x071-201818
i386                   randconfig-x076-201818
i386                   randconfig-x074-201818
i386                   randconfig-x078-201818
i386                   randconfig-x077-201818
i386                   randconfig-x070-201818
i386                   randconfig-x072-201818
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
i386                   randconfig-x0-05071422

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
