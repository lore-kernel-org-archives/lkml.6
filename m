Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F683C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEBE213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbfBZJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:55:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33616 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfBZJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:55:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id c55so10207335edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DTcPc9unKXiAzHSWlt/UXbfT6gn/P9LiAYJI/3aWBq4=;
        b=IU4gdXfNPy7nHX2dfnaJCITL905upLlTXqogbg5hbTIzjuSsK2aM7Q/shjBCnGc6yM
         uVInhwVTJqFN89WKgXzHp5gWCwL1kZj+dCAdqfiidIGjmZelxYq7cXw3DmUzJFFk1Gxt
         vIMuk/tAwx6bSx0ECOxVt7Hdx796KeuZfLVBXG04OL6W/nvt4k+cN0pawJ7GZMJs9GPi
         dI3V+KiD49Alz04iU76buuxryAy0KBbY6RvGaLWM7jJOMLI4BKKMBLyIwzhatfibH1Zp
         bgK+nLKcZYBKsEVFx2gA6YqbKPI+z+q2klvhDSsZt7BJ5sYywjMogKnc37WjchqHCCB7
         B82g==
X-Gm-Message-State: AHQUAuaMj5C9IBSy7TMFBofG0H8ORwnmyZ3x/aW6BB8wppUqLPR4NUma
        rN+unTHyoVhBHqRbGanM5QCuhaUSalqaNA==
X-Google-Smtp-Source: AHgI3Ibhv5sy3EUlt5jaLsctKPpypl/t+pUsPlIyaRbDk9Pjt49CmYLQDcV5F2bOwCN36ue5Zt7cyg==
X-Received: by 2002:a50:8957:: with SMTP id f23mr1741904edf.286.1551174947161;
        Tue, 26 Feb 2019 01:55:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h8sm1463119edb.36.2019.02.26.01.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:55:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D329E183BB9; Tue, 26 Feb 2019 10:55:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 4.20 161/183] mac80211: Change default tx_sk_pacing_shift to 7
In-Reply-To: <20190225195122.158033941@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org> <20190225195122.158033941@linuxfoundation.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Feb 2019 10:55:45 +0100
Message-ID: <87k1hmrhzy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> 4.20-stable review patch.  If anyone has any objections, please let me
> know.

LGTM. Any chance of getting this into 4.19 as well? It doesn't apply
as-is, but I can send an equivalent patch (where?).

-Toke
