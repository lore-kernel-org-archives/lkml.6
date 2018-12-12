Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0285E20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0285E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeLLXp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:45:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46655 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeLLXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:45:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so84528pfe.13;
        Wed, 12 Dec 2018 15:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fu/UTOUx8M++eI/2XeJerQyVxhQt4SjyIcrXQcGC8TU=;
        b=PzBTUdgbcGLfKoOxZSPU6gDtAbdQUMZ7uKMM4XoUH0jyOliOQr2E0ZBG2rtiGc5uMX
         14jBT72VvOdaSeKpyqwCU5qeThoEtEEwmpDXMHw6arf1UOfuMD4RB73v4SjnJEU55dRC
         z2p+JfCiLBxyFuN9yDMV8l3+P0lc8YCkb9qiJAzHQ0X94G/1d6PKbUMQcmClgn5haKPy
         onO1RXlelfrycGbukDXCq15Key1slkooh4CGbXnrv9koXlWiJd1EmOQgaIGL/0Pf5MkV
         Jh7wuY/MIpvoy/5BwJZtsY/JcW0oUqNxM9fax8+s0ft6aOSkg6pCMDEoPfUXc3ACRmuf
         IADw==
X-Gm-Message-State: AA+aEWZA5oKK3GKcHhD1MjkwIgw4fGbvFkDHvCEmYNwbz0BbIXvPxrQn
        TUiyParGD/ex0bVksguHajc=
X-Google-Smtp-Source: AFSGD/XyToAgswKzKgw8lYJyw2P0qSyXWvO5XIAvFvhXqXm2Y+L1E2QBUc+DgenMvOeq804+BTYn+A==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr19932914pgh.30.1544658322409;
        Wed, 12 Dec 2018 15:45:22 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m19sm21375pgn.35.2018.12.12.15.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:45:21 -0800 (PST)
Message-ID: <1544658320.185366.407.camel@acm.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Dec 2018 15:45:20 -0800
In-Reply-To: <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
References: <20181213073245.5b2d2536@canb.auug.org.au>
         <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
         <20181213094820.62d26354@canb.auug.org.au>
         <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-12 at 15:39 -0800, Alexei Starovoitov wrote:
+AD4 On Thu, Dec 13, 2018 at 09:48:20AM +-1100, Stephen Rothwell wrote:
+AD4 +AD4 Hi Alexei,
+AD4 +AD4 
+AD4 +AD4 On Wed, 12 Dec 2018 12:53:11 -0800 Alexei Starovoitov +ADw-alexei.starovoitov+AEA-gmail.com+AD4 wrote:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 On Thu, Dec 13, 2018 at 07:32:45AM +-1100, Stephen Rothwell wrote:
+AD4 +AD4 +AD4 +AD4 Hi all,
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Commits
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4   3bdc28aa2340 (+ACI-selftests/bpf: add btf annotations for cgroup+AF8-local+AF8-storage maps+ACI)
+AD4 +AD4 +AD4 +AD4   1dfd1959fed4 (+ACI-bpf: add bpffs pretty print for cgroup local storage maps+ACI)
+AD4 +AD4 +AD4 +AD4   3adc62d9a5be (+ACI-bpf: pass struct btf pointer to the map+AF8-check+AF8-btf() callback+ACI)
+AD4 +AD4 +AD4 +AD4   9cf3a785dc4c (+ACI-selftests/bpf: use +AF8AXw-bpf+AF8-constant+AF8-htons in test+AF8-prog.c+ACI)
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 are missing a Signed-off-by from their committers.  
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 the must be a script mistake?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 I clearly see SOBs for all of them.
+AD4 +AD4 
+AD4 +AD4 For example:
+AD4 +AD4 
+AD4 +AD4 commit 3bdc28aa2340bf1e5af753287b373522bd1c02a9 (bpf-next/master)
+AD4 +AD4 Author: Roman Gushchin +ADw-guroan+AEA-gmail.com+AD4
+AD4 +AD4 Date:   Mon Dec 10 15:43:02 2018 -0800
+AD4 +AD4 
+AD4 +AD4     selftests/bpf: add btf annotations for cgroup+AF8-local+AF8-storage maps
+AD4 +AD4     
+AD4 +AD4     Add btf annotations to cgroup local storage maps (per-cpu and shared)
+AD4 +AD4     in the network packet counting example.
+AD4 +AD4     
+AD4 +AD4     Signed-off-by: Roman Gushchin +ADw-guro+AEA-fb.com+AD4
+AD4 +AD4     Cc: Alexei Starovoitov +ADw-ast+AEA-kernel.org+AD4
+AD4 +AD4     Cc: Daniel Borkmann +ADw-daniel+AEA-iogearbox.net+AD4
+AD4 +AD4     Acked-by: Martin KaFai Lau +ADw-kafai+AEA-fb.com+AD4
+AD4 +AD4     Signed-off-by: Daniel Borkmann +ADw-daniel+AEA-iogearbox.net+AD4
+AD4 +AD4 
+AD4 +AD4 But it was committed by you, not Daniel.
+AD4 
+AD4 since there were only 4 commits I fixed them up manually.
+AD4 But this approach doesn't scale.
+AD4 We do rebase our trees when we need to fixup or drop patches and
+AD4 at any given point a number of commits will be committed by me
+AD4 and another set by Daniel. When we rebase we cannot keep adding
+AD4 our SOBs to the other person SOBs.
+AD4 Then comes the next rebase and we get to the point of
+AD4 double and triple SOBs ?
+AD4 
+AD4 I think you need to adjust the script to something like:
+AD4 SOBs by Daniel +AHw Alexei +AD0APQ commit by Daniel +AHw Alexei
+AD4 in bpf and bpf-next trees.

Are you aware of Linus' opinion about rebasing? If not, please have a look
at https://lkml.org/lkml/2016/3/26/71 or https://lwn.net/Articles/328436/.

Thanks,

Bart.
