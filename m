Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6758F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfAQOrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:47:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33456 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfAQOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:47:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so1242696wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Z932+bUN2NrjzHFwKIthg0K6iUxuRA6Dyq6+sEI2Ac=;
        b=MIATvQES/pBEGtk7nf9vnFNYs/rDeBQsfjb587/CWqkkyVVpWCsPaWk4dyrqV4MnGG
         mV7ekkrFdbr4PtVlB+0Ugxxo4JcXAm+nRl5OFTgAw9ur9HxaJsBVYnNyA1+d72wVNUW4
         Vy4S0jxvj8AlvWOEEAEsBuULcHaVgJjxLF/t8cJii9Teih7PCE/aVaUUsefrdAncOSyF
         OdqKsg8nqhF3J/yGjz8SAJ1oBwshTC0cgYe61T10JSoyhHt+ZbGGV0Cl5dHkXWt4H54I
         1HI7N0oMH/ztKPNUDtENnBxmOnmrsk8JXqwA7rzFe6MxPXu+IyC4OebLyGK3/xABDNgG
         Gk9Q==
X-Gm-Message-State: AJcUukfaWpbeHz7Blt6TvDQ5uHY2QioveeAXmH1ZqDUDzV50MHJNEBod
        E9wTys+/sclzkUwhRmH32Z0vtw==
X-Google-Smtp-Source: ALg8bN7jRrC4WUXpHG+CEkLGw14ik0Xy5n7TGTPjQodfcTd6+7O1+nkJMQ/+CzfQ87pq85z5XZcgDw==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr12178463wmk.149.1547736467104;
        Thu, 17 Jan 2019 06:47:47 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id x81sm40888577wmg.17.2019.01.17.06.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 06:47:46 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:47:44 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net,
        mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PM / EM: Document the Energy Model framework
Message-ID: <20190117144744.GF14385@localhost.localdomain>
References: <20190110110546.8101-1-quentin.perret@arm.com>
 <20190110110546.8101-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110110546.8101-2-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/01/19 11:05, Quentin Perret wrote:
> Introduce a documentation file summarizing the key design points and
> APIs of the newly introduced Energy Model framework.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

Looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,

- Juri
