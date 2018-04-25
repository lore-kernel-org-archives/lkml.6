Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652845-2-3695676409867386102
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652844; b=fRB5+qLMoi22IzoAo7En6Bls1CCzC89NWl24P/PYhXyi6mfoJs
    AlwKVdqnRYVwMgHo83pjAl4TKJH0wri/gYiUYWS5ngAssm8X1Iu4cefRGooJHO+W
    wvPhdjyn5Cz9zPqCl69PxPDbRSLSPEk3bzD7LFi/yorE1LFXdda0xecm9Npg5qsQ
    b00tfGyPVd6sqgd3AxCWpHQopGjqOO6ehN3V03Govq63MVNz+D7uYbpOuUlaeFza
    vzfw8ANoqHmPawLSC5iqBN/o37Gv6I5wFVv0rPRw/bAkiGPUSConfB9V3BweZgWK
    6AFlQHmJDj+A2KUCkHUDr/pt3lj2MyQbI49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524652844; bh=k/p+W
    MeSZHqMuBe+cywpx6+K7+X0NUfqOkUoYTRL6vk=; b=OrmliVxlYaEVrsEe1tIXW
    5zGFtg4ipBk+4UzMttby38wE+X1Bd6s2xvfSqPvh/WJ30cg19MTBlZ0KTYCCRXyv
    sK44KbOL1AWrK6VLUELecaHpNA7gBrejuF/WkGRyTBgYcsz7JMNsnntPLUWdJWRF
    a4AK1aaYjmhrx7c4EYPP2kkl6ihx0d0sxDyTHXW+fgSmXQFKj4YL4R3dzkXFwiy0
    BWz8sU3EssuSXvcDxETfL5bTSDQcTpbUA3+PJlH8xr/R+meb1oY/HhALjg5Sq2ki
    KnxPFKm7kpe2KBdxqTCSWUr/wh27qAXC+dj3pfDvFSj1nixzEOlkuK/BwRFG1Hev
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGtpSWQX52e3/FMh1MoUsMIlMycdNMu19/Jv58NOGPCmGLg1NRzH8m7SHizRVxWuYkyDWH+bD2q5ubT4pVuQuvh/g1MQ9Qt34VOGLCqT6ZgDZDlejImo
    F4ZPXaL3Ho/0s9FS/Z0Yxza0mSCDz633cLMij/ekZsKl1iLQFhoj5KJDtt8UfQtxhywzXdDCQYVnyjEXpcFQVMu5SIRlWLeEZn73BNPS59HjLGBsmXa6D6+V
    HFdQbSliUyCACM8J02UJQQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=ag1SF4gXAAAA:8 a=FK2O_W7RSZ9V_p7GEloA:9
    a=14mzI-X6DnnwvUJ1:21 a=1zp8Mvc82ahYbWPT:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 087/183] x86/hyperv: Stop suppressing X86_FEATURE_PCID
Date: Wed, 25 Apr 2018 12:35:07 +0200
Message-Id: <20180425103245.991958948@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Sasha Levin <alexander.levin@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Aditya Bhandari <adityabh@microsoft.com>, stable@vger.kernel.org,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Zhang <dazhan@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>


[ Upstream commit 617ab45c9a8900e64a78b43696c02598b8cad68b ]

When hypercall-based TLB flush was enabled for Hyper-V guests PCID feature
was deliberately suppressed as a precaution: back then PCID was never
exposed to Hyper-V guests and it wasn't clear what will happen if some day
it becomes available. The day came and PCID/INVPCID features are already
exposed on certain Hyper-V hosts.

>From TLFS (as of 5.0b) it is unclear how TLB flush hypercalls combine with
PCID. In particular the usage of PCID is per-cpu based: the same mm gets
different CR3 values on different CPUs. If the hypercall does exact
matching this will fail. However, this is not the case. David Zhang
explains:

 "In practice, the AddressSpace argument is ignored on any VM that supports
  PCIDs.

  Architecturally, the AddressSpace argument must match the CR3 with PCID
  bits stripped out (i.e., the low 12 bits of AddressSpace should be 0 in
  long mode). The flush hypercalls flush all PCIDs for the specified
  AddressSpace."

With this, PCID can be enabled.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Zhang <dazhan@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Aditya Bhandari <adityabh@microsoft.com>
Link: https://lkml.kernel.org/r/20180124103629.29980-1-vkuznets@redhat.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/hyperv/mmu.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -137,7 +137,12 @@ static void hyperv_flush_tlb_others(cons
 	}
 
 	if (info->mm) {
+		/*
+		 * AddressSpace argument must match the CR3 with PCID bits
+		 * stripped out.
+		 */
 		flush->address_space = virt_to_phys(info->mm->pgd);
+		flush->address_space &= CR3_ADDR_MASK;
 		flush->flags = 0;
 	} else {
 		flush->address_space = 0;
@@ -219,7 +224,12 @@ static void hyperv_flush_tlb_others_ex(c
 	}
 
 	if (info->mm) {
+		/*
+		 * AddressSpace argument must match the CR3 with PCID bits
+		 * stripped out.
+		 */
 		flush->address_space = virt_to_phys(info->mm->pgd);
+		flush->address_space &= CR3_ADDR_MASK;
 		flush->flags = 0;
 	} else {
 		flush->address_space = 0;
@@ -278,8 +288,6 @@ void hyperv_setup_mmu_ops(void)
 	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
 		return;
 
-	setup_clear_cpu_cap(X86_FEATURE_PCID);
-
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
 		pr_info("Using hypercall for remote TLB flush\n");
 		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
