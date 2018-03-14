Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1838165-1521036500-2-12978267423191015248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521036499; b=HjIktKYV3DTHpbkyZ46Y3g0SQAIu29fYOke4p/YUagAPuG6
    Rj6r6etoOOOL134v/nykjmx8JKdKRD7HcXMq7cBzKxb8Q6my/BLw9THtiwmVYxk1
    RBPPKFP6xaBiirX2hnP07gysem9Yg/W20zXjIus6KNDRSDKRVW8S8dxzbRF5RKbi
    91mE4rCkVEdliQiQEZi5gIRtVlvPhmiyTfG9IJiK5bWvPCIe1cuCiN4BVFZIGNz6
    JvQ5Xc55CqWzO0E2WJKpTS7xcsDwdv3KF1J92G0Bb9/BMhlVk3iHJn1406i98Z/g
    hDOdSBwdYPj4xerVPrrVJq3zxufwcE8MGOr2b3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521036499; bh=j
    zle4j1PKjOaqI7TH9mwEZVLNrUKI5WFVoLDekULMn0=; b=JdKZpkWAm56zd9T1A
    BjDAJjLECXlJAGJeQxsIFdK3LRlJaWpYC35s3TFMVonMzv1H5GdbaEJty0JjjrkW
    mJpjepCD3ljvC+8SkfA2HepyRufekSGoikisiN6iXkC/g/gZZ6QAknzmyMUtMObY
    d7gMaZJf5xEQS7keO2hOadx/g8/6izCx+capaIlIgPW3TSyjiODTxkZV4EFnFa7S
    B7P+V8kIVo7IGuOIesiMAyJSRmzVEStiUOUnugD3cnmziwReqGuRRyh+HTOHT7FW
    04SiMf/8ngPtMMcWATuEvCG3/7JZ29ZkG0JzJcYoHzSWYat7BkspIfPGFiwJMFQl
    8I39A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,470,1515481200"; d="scan'208";a="10189126"
Date: Wed, 14 Mar 2018 19:38:03 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: <hariprasath.elango@gmail.com>
Subject: Re: [PATCH 6/7] staging: wilc1000: remove unwanted braces and
 correct code alignment
Message-ID: <20180314193803.39bdd142@ajaysk-VirtualBox>
In-Reply-To: <31227bdc32df8b76d6a81ca224e1381020f681df.1521030891.git.hariprasath.elango@gmail.com>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
 <31227bdc32df8b76d6a81ca224e1381020f681df.1521030891.git.hariprasath.elango@gmail.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 ganesh.krishna@microchip.com, aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Mar 2018 18:15:04 +0530
<hariprasath.elango@gmail.com> wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> Remove the unwated brace and corrected the code block alignment
> accordingly

Changes done in this patch are already taken care. Today, Greg has
applied the patch which had these changes. This patch can be ignore from
the patchset.


Regards,
Ajay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
