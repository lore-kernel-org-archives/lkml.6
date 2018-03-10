Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeCJN0g (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:26:36 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:51410 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932759AbeCJN0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:26:35 -0500
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
 <20180310091838.GA8261@pd.tnic>
 <2cfade76-7d3d-38be-8da6-5927a043a91b@maciej.szmigiero.name>
 <20180310131202.GB8261@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <f3b93016-758c-e033-9e08-fcca650b00e4@maciej.szmigiero.name>
Date: Sat, 10 Mar 2018 14:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310131202.GB8261@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2018 14:12, Borislav Petkov wrote:
> On Sat, Mar 10, 2018 at 01:26:00PM +0100, Maciej S. Szmigiero wrote:
>> Without them, it is easy to crash the driver when just playing with
>> microcode files
> 
> You're not supposed to play with the microcode files. If you do and
> something breaks, you get to keep the pieces.
> 
> If the official microcode files have a problem, then I'm all ears.
> Anything else contrived which doesn't actually happen unless someone
> manipulates them is not an issue the microcode loader should protect
> against.
> 

So, shall we remove data consistency checks of various root-only
syscalls then? :)

Maciej
