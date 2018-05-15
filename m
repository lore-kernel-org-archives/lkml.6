Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2726463-1526393302-2-14763045863247328690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526393301; b=CO+fKFXNKeacjs8drvlybFFivM+a7et9O+zA+dwo14pbQt5cQ/
    6GRpNklQesP5Gq6SHER+IsKq3ZGHvl3CftgZnOtBI/3dIyOx3nwLeH9IUYrFJgUa
    BEk1WiBO1Uak2PkzQ4aObCAImIUa3LDvkFKT9A7Yp1yGysYBlGdo7HrpR6qu8E6m
    Ue09hl3CSlDWkndixdYKjszbuAx4uqoDs7bB3AtuLia8SjObGQLawXy9PXEQZYj9
    0r5Kyh36QO2Gi5j3Awtq2f3+oFrmBk0lcm6zz3Em2NHUcRnhVmvw88D//Zc3Cc17
    vf2eIAyPlp1hKspeunVwna5MrGquxPbt/Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526393301; bh=7dxPb
    UAwuYAOtle+urE5kFTGNFXJV1VF1qwOjwIhjpM=; b=AttVcDTMiWV6dqf9u+LTV
    9e//QlY5lc+Pu1jsYxzFFpNL5Nr89xCZG/HvJecu7UrG/qCc72By4CrosDpHhcQr
    4DSWvLa7bFa+GygSis5GtqF4HbcFp0Ly9rwyBKZhlFJngQqj9OwA8QKj31OrsInI
    6bCtj5hfy7w0183XjbshLWCamL7FbBupLB3XncUAwMYCduFrdklJZE8cxX6pF+1g
    bHYAQGQBGOtl3n+4R5XVWSc5kebQA17xMy8m6ZSdFPUoN4vTphIxz+7mS9/ZzoHD
    7tec5TEZM/VI9u1DeEsIxmRBFOIc7j5Zg+UoqzHTw69TisjUSvQ+ztNPSaVZ1M3h
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHSfqj7EK7HBt3ULBO9ogLOF5u/0gHK5R8d1O0itBVM0XVjCzJeMP7sKThajhsnmLBFI71slhL/ur7Z72+EeQdd0CVtwvd8vX/XY5je7mwJnRcjrabz
    nCS24qWlDMv1YZAWL9kCVPY/FzbnHO/Tns3JnqBDAhcIy4eNUfh7hFdS+hinPIRrvSVmuJ2tBWhnZYuelGJM9oxq2NKCpo/1qqDVir9cjHz63Bsc0+8ir6rx
    /jkKOyRdFosvNlUlmuFYjA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=0U8zXtxtX8JFn1drReQA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 16:12:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 34/40] atm: simplify procfs code
Message-ID: <20180515141232.GD31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-35-hch@lst.de> <87r2mq2rll.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r2mq2rll.fsf@xmission.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 linux-afs@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 07:51:18AM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Use remove_proc_subtree to remove the whole subtree on cleanup, and
> > unwind the registration loop into individual calls.  Switch to use
> > proc_create_seq where applicable.
> 
> Can you please explain why you are removing the error handling when
> you are unwinding the registration loop?

Because there is no point in handling these errors.  The code work
perfectly fine without procfs, or without given proc files and the
removal works just fine if they don't exist either.  This is a very
common patter in various parts of the kernel already.

I'll document it better in the changelog.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
