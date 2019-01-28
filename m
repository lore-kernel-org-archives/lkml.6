Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D467C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768CB2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfA1QWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:22:12 -0500
Received: from pinero.vault24.org ([69.164.212.126]:43768 "EHLO
        pinero.vault24.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388113AbfA1QWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:06 -0500
Received: from feynman.vault24.org (c-98-243-50-21.hsd1.mi.comcast.net [98.243.50.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by pinero.vault24.org (Postfix) with ESMTPS id 0B57D60AE;
        Mon, 28 Jan 2019 11:22:06 -0500 (EST)
Received: by feynman.vault24.org (Postfix, from userid 1000)
        id 4ABF33020AE7; Mon, 28 Jan 2019 11:22:05 -0500 (EST)
Date:   Mon, 28 Jan 2019 11:22:05 -0500
From:   Jon DeVree <nuxi@vault24.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        carnil@debian.org, t.glaser@tarent.de, asmadeus@codewreck.org
Subject: Re: [PATCH] x86/kvmclock: set offset for kvm unstable clock
Message-ID: <20190128162205.GA31660@feynman.vault24.org>
Mail-Followup-To: Pavel Tatashin <pasha.tatashin@soleen.com>,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        carnil@debian.org, t.glaser@tarent.de, asmadeus@codewreck.org
References: <20190126174956.22769-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190126174956.22769-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a bunch Pavel, patch works great for me on 5.0-rc4. I also
backported it to 4.19.18 and tested it there. Should this be CC'ed to
stable@ as well?

-- 
Jon
X(7): A program for managing terminal windows. See also screen(1) and tmux(1).
