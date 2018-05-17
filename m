Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1118678-1526519737-2-2286429506754140194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526519737; b=fh1wjkpGL5rfzd91mKHz54hSa7wDnrygy//pBRHGmI0LzPb/3Z
    XjkdvsqtzqeJvZPCLNOfRICw44YTGuFPpRpRYjXDk90iv7UDnVrmAeD67liby+gv
    qG8sgX8nEUyOUoIm517Pk5WW0d0O+VIz/WeMFIba6RY+/d09zsovJVqGSdxBy5Lk
    nD8BZUagqRnYMbf9+cLCAXcg0NKh+jAgD5yJfuy1UuLJmV+BfS3QRFj8UsiUD492
    vnSsE21NuSNLmp5zeOM0shRoraX4rQMdL+y3s7TqIvtUl+FzwcH6Sn66QtXf+BK6
    Tu6hl2rzkqWYjUsKK3PWYBltWmkE0yamDubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:date:in-reply-to
    :message-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526519737; bh=LGdhV
    1hWJoYS5CghomCm4IXAMxUfmepbonWZdeWAmK0=; b=ehI1lsDMA1Bd+QUjwiL7Q
    B0JQrSzQqA2YPcPePeiXbbspBjzmN74MkcyQd7/d+30CRjF5oMDhwBl0sEXksRaL
    sh2KnfEpNapfkR3OFJ/UWun190zLP9uq0SmbjJSXecrWFkgDJ7pmhQ7Nh1OHGGru
    AORFcH0KPijTU6m8fzej1hHBcX3jouFcv4t9JSrik3oDvs57hFe8n+QWz4Hfnh3l
    uAh6LwXxpcenHLRb0jr0phRhsAXxVWfgNmh+4PnR1hcF21YUYCDSG/Myi/MWIiqL
    U1YZg5n4J2Fbbki5hepDyiIMi2PxRdZYdx/sBMfKp+ECFP+sOVaLit+ZIuJvPl9S
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOLSF/iPbPJU74t0SJ/iKevQiapLWxnOwf8VK2MekdCv/CRCKE/DT3MGtDTYHiGIYD46236ycnVRK8mfEsdjvlmeSHunWIKM3HfPN0z29IPDhyXaxb9V
    ajnO1e9QUas0m3X1wgsh4hoXswUXQjAY1vPwQFmzUPbXC51GiOIg+kN4MjlfR/JXCjRS430Llit59kez2vtIR4WHPxSDKvLEFmI1ysv1wpqO2dnqfq/IM8SY
    8oypn0OVj4YLEcQLp1fMAg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=tFMGEsm6hhiEteqTmkIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-35-hch@lst.de> <87r2mq2rll.fsf@xmission.com>
 <20180515141232.GD31296@lst.de>
Date: Wed, 16 May 2018 20:15:21 -0500
In-Reply-To: <20180515141232.GD31296@lst.de> (Christoph Hellwig's message of
 "Tue, 15 May 2018 16:12:33 +0200")
Message-ID: <87efibjd5i.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1fJ7Vv-0001cr-Gj; ; ; mid=<87efibjd5i.fsf@xmission.com>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=97.90.247.198; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19Qg24/tt4gRhuDfyA9/V080o3wAW6Vehw=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: *;Christoph Hellwig <hch@lst.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 154 ms - load_scoreonly_sql: 0.04 (0.0%),
 signal_user_changed: 5 (3.4%), b_tie_ro: 3.8 (2.5%), parse: 0.89 (0.6%),
 extract_message_metadata: 10 (6.2%), get_uri_detail_list: 0.75 (0.5%),
 tests_pri_-1000: 5 (3.3%), tests_pri_-950: 1.45 (0.9%), tests_pri_-900: 0.91
 (0.6%), tests_pri_-400: 22 (14.2%), check_bayes: 21 (13.5%), b_tokenize: 4.9
 (3.2%), b_tok_get_all: 7 (4.3%), b_comp_prob: 2.0 (1.3%), b_tok_touch_all:
 4.3 (2.8%), b_finish: 0.89 (0.6%), tests_pri_0: 103 (66.7%),
 check_dkim_signature: 0.37 (0.2%), check_dkim_adsp: 3.2 (2.1%),
 tests_pri_500: 3.4 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 34/40] atm: simplify procfs code
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Sat, May 05, 2018 at 07:51:18AM -0500, Eric W. Biederman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > Use remove_proc_subtree to remove the whole subtree on cleanup, and
>> > unwind the registration loop into individual calls.  Switch to use
>> > proc_create_seq where applicable.
>> 
>> Can you please explain why you are removing the error handling when
>> you are unwinding the registration loop?
>
> Because there is no point in handling these errors.  The code work
> perfectly fine without procfs, or without given proc files and the
> removal works just fine if they don't exist either.  This is a very
> common patter in various parts of the kernel already.
>
> I'll document it better in the changelog.

Thank you.  That is the kind of thing that could be a signal of
inattentiveness and problems, especially when it is not documented.

Eric

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
