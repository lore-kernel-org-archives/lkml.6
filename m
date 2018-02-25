Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeBYTjn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:39:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36341 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeBYTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:39:40 -0500
X-Google-Smtp-Source: AH8x226BAKxumWsuyzS424Xthr4ZlcJr4LDPjbF2Zf0CMfHpVZDRZTfyF/PW6pOmhIyyHeFqD6z/UA==
Subject: Re: [OpenRISC] Removing architectures without upstream gcc support
To: Al Viro <viro@ZenIV.linux.org.uk>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jonas Bonn <jonas@southpole.se>,
        Arnd Bergmann <arnd@arndb.de>, Chen Liqin <liqin.linux@gmail.com>,
        linux-hexagon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>, David Howells <dhowells@redhat.com>,
        openrisc@lists.librecores.org, James Hogan <jhogan@kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-metag@vger.kernel.org,
        Lennox Wu <lennox.wu@gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop> <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e49978cd-3a68-85f3-0f2c-36b10076f9b9@twiddle.net>
Date: Sun, 25 Feb 2018 11:39:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223181943.GF30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 10:19 AM, Al Viro wrote:
> For m68k,
> IIRC, qemu is mostly for coldfire and friends with aranym
> working for m68k/MMU testing.

Laurent Vivier is in the process of fixing that upstream, it won't all make
qemu 2.12.  He has a branch with full support for a Mac Quadra 800:

  https://github.com/vivier/qemu-m68k/tree/q800-dev


r~
