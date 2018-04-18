Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeDRN51 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:57:27 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:53554 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753218AbeDRN50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:57:26 -0400
Subject: Re: [PATCH v4 01/10] x86/microcode/AMD: Subtract SECTION_HDR_SIZE
 from file leftover length
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name>
 <20180318161200.GA2036@cz.tnic>
 <fe58b934-eafe-9ed6-a089-a58caaf90fc8@maciej.szmigiero.name>
 <20180418135327.GA4795@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <a3e54b86-412b-9d91-15d5-1055344eaa24@maciej.szmigiero.name>
Date: Wed, 18 Apr 2018 15:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180418135327.GA4795@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.2018 15:53, Borislav Petkov wrote:
> On Wed, Apr 18, 2018 at 02:39:27PM +0200, Maciej S. Szmigiero wrote:
>> Can't really find this commit in any tree I have looked at (bp.git and
>> tip.git at kernel.org).
>> Was it pushed somewhere else?
> 
> No. Still waiting for the rest.
> 

So, should this patch be included in a respin or not?

Maciej
