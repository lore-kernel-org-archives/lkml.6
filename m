Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeCWQTT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:19:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42532 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeCWQTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:19:18 -0400
Date: Fri, 23 Mar 2018 11:18:49 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <239ed1f7-cf4a-f187-549f-ea7e08b4e765@maciej.szmigiero.name>
References: <cover.1521150415.git.mail@maciej.szmigiero.name> <30562911-7fde-782b-d1b2-03e30b6987c5@maciej.szmigiero.name> <20180322161130.GA11575@cz.tnic> <239ed1f7-cf4a-f187-549f-ea7e08b4e765@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v4 06/10] x86/microcode/AMD: Check patch size in verify_and_add_patch()
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
From: Boris Petkov <bp@alien8.de>
Message-ID: <B7ADE414-A93D-4FD1-9B0D-F5360747C2EE@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 23, 2018 9:40:50 AM CDT, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> wrote:
>It is possible to keep verify_patch_size() unmodified (with unsigned
>int
>and u32) but microcode container files >4GB in size then may be
>rejected,

If we ever have to support that - which I'm pretty sure we won't - more changes to the container format and parsing will be needed anyway.

Thx.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 
