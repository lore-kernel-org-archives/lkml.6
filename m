Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756130AbeEAQTV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:19:21 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:54664 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754790AbeEAQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:19:19 -0400
Subject: Re: [PATCH v5 2/6] x86/microcode/AMD: Add microcode container data
 checking functions
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <ea8b42f1d7a0fa75b2a13758f71f6c486862ab47.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090447.GA6509@pd.tnic>
 <c4a49546-a4bb-c7a5-116a-be537bacb688@maciej.szmigiero.name>
 <20180501081819.GB31863@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <f716fae6-f28c-d09d-3bb6-d20676c56683@maciej.szmigiero.name>
Date: Tue, 1 May 2018 18:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180501081819.GB31863@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.05.2018 10:18, Borislav Petkov wrote:
> On Tue, May 01, 2018 at 12:27:17AM +0200, Maciej S. Szmigiero wrote:
>> These checking functions are supposed to be called in order:
> 
> We don't do magical rules like that - you either verify fully and
> correctly or you don't bother at all. And since you're adamant that this
> verification needs to happen, then please do it completely.
> 

These are internal functions to this driver, declared as "static", so
there is no problem if they have additional requirements with respect
to their call order.

But it is, of course, possible to do these checks also in the later
checking functions as you wish.

Maciej
