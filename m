Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230917-1523609215-2-981015518139925640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523609214; b=Av0Uxo+UdXGqk/Vn7aa/+Dyk7ffYHZkfp+UInMehk6PhTFNfgT
    e4h29YHgpEqp6MszlEcs/4seX3JQoI0U9hAh1GsG9maEHSStSVeqqpGf4v3TUHsY
    s+Z3Ayefqpg36AaKv1Z9kW1am1TaHfjmzULSxP3SPysq/U9gfbPik3l0B1h/RI17
    B21BeReGqT105DA0nCuis5fm6aACka+3JBIAfGSE9adOLRB/6tDmCRSog1iZrXM8
    oseImBee2Iymb/mzbAUyGhLrlq+Ejw6oBPBMzFXYwpirq3mHB3ehPl8Pe1T7aBBw
    p+0iGAuCEnSErbT+UnHVcueacyuRSWqh10Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523609214;
    bh=sHKRvQODT+9R8PdKRSMBFX3MDsVvVHAfmFhrnUI1roQ=; b=ucLMukvHCmq0
    vlgC6ud9YvLN0mTRaCQMSggFdQXCldh7b2w8xR0ajCCVLSVtnr/Fr59ZsqrlW+mv
    uinwUvrUFmgfnCtyNR8BKs0+cD2MNBIgv6gSiypzgkiLVFdSz9UQHYP1IGUaaktd
    JXGfYS/HhYZZcbSRXBQ7U5DRoNYv9KnkzAgLxT4zFvxJ8oIJpngz5inBraK+GgBJ
    bEyoiS8eO3A43qNYD3CiQVgmjjIinTPwQf7MYSTyuvxsThRoZwKlYByKo8lg2dkN
    tJF1O8UXTGEDJ1jHuXFzYO5Uo5b+LkmEF0o9beEvWL0Wc02iNhP8QkFMqz3v88vE
    b/KjYGzeQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBBZxvCgrRKermpJ6Uv6AuQkFJ44W9vASIrFtQERXx0CMdtqmJe/W9x4oikFakUEkW36dU3Rfd9wBSohaHvZR34uTSurs44Udhw/DjiD96ZXRg9g6Jmr
    bnmIwaHETI3f+xjVRwsjbftl4TetJgU42hiO62cLAP4LKGrFKb07UKI7gcbIsL7aWiEX2oufc6aOKZ9XdO9fa9NYHEoqCBCKARg/a/WHtBBWBOHoDprn7ocS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9bmo1EOpP-FgXpdHDIMA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeDMIqv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 04:46:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbeDMIqu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 13 Apr 2018 04:46:50 -0400
Subject: Re: [PATCH] mm, slab: reschedule cache_reap() on the same CPU
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <20180411070007.32225-1-vbabka@suse.cz>
 <20180412004747.GA253442@rodete-desktop-imager.corp.google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <41acaf67-cf4c-e5b2-97e4-2d7d5a383ffb@suse.cz>
Date: Fri, 13 Apr 2018 10:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180412004747.GA253442@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 02:47 AM, Minchan Kim wrote:
> On Wed, Apr 11, 2018 at 09:00:07AM +0200, Vlastimil Babka wrote:
>> cache_reap() is initially scheduled in start_cpu_timer() via
>> schedule_delayed_work_on(). But then the next iterations are scheduled via
>> schedule_delayed_work(), i.e. using WORK_CPU_UNBOUND.
>>
>> Thus since commit ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on
>> wq_unbound_cpumask CPUs") there is no guarantee the future iterations will run
>> on the originally intended cpu, although it's still preferred. I was able to
>> demonstrate this with /sys/module/workqueue/parameters/debug_force_rr_cpu.
>> IIUC, it may also happen due to migrating timers in nohz context. As a result,
>> some cpu's would be calling cache_reap() more frequently and others never.
>>
>> This patch uses schedule_delayed_work_on() with the current cpu when scheduling
>> the next iteration.
> 
> Could you write down part about "so what's the user effect on some condition?".
> It would really help to pick up the patch.

Ugh, so let's continue the last paragraph with something like:

After this patch, cache_reap() executions will always remain on the
expected cpu. This can save some memory that could otherwise remain
indefinitely in array caches of some cpus or nodes, and prevent waste of
cpu cycles by executing cache_reap() too often on other cpus.
