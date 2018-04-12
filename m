Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeDLTrD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752943AbeDLTrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:47:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E56521737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 12 Apr 2018 15:46:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and
 fixes
Message-ID: <20180412154659.29f5c905@gandalf.local.home>
In-Reply-To: <20180412142845.6b97b223@gandalf.local.home>
References: <20180412015359.244491749@goodmis.org>
        <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
        <CA+55aFzPhRdZSX2wMiiact8RpnYMHy48RK+Ng7n_Ek_vpYy3fg@mail.gmail.com>
        <20180412142845.6b97b223@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 14:28:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Primary key fingerprint: 5ED9 A48F C54C 0A22 D1D0  804C EBC2 6CDB 5A56 DE73
>      Subkey fingerprint: B5D7 BDD5 67E0 67A3 EE0C  9FBE 3F0B D661 FC59 E3D3

Don't use this key.

Konstantin wanted me to make a ECC key, which I did. Here's the new key:

   Subkey fingerprint: 514B 0EDE 3C38 7F94 4FB3  7993 29E5 7410 9AEB FAAA

-- Steve
