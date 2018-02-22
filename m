Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBVGQJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:16:09 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34483 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeBVGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:16:07 -0500
X-Google-Smtp-Source: AG47ELtJKhieuK7lAVK2O7jsEB/Br7RwUR+JlckGIe1zUDAXdKwcpZlz5XbFFukCNFwr642CmAuBcg==
Date: Thu, 22 Feb 2018 01:16:04 -0500
From: Bo YU <tsu.yubo@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netlink: put module reference if dump start fails
Message-ID: <20180222061603.GA11532@yubo-2>
References: <20180221034159.14685-1-Jason@zx2c4.com>
 <1519192048.55655.35.camel@gmail.com>
 <CAHmME9px8Bwjz-D0dbSgm3vRPiEaBavEaG=2bGWC0_L3api5rw@mail.gmail.com>
 <1519225917.55655.42.camel@gmail.com>
 <CAHmME9pHTfryRwr7rA36KPoLKYyxhs-h0De0riSkFb7+phn91Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHmME9pHTfryRwr7rA36KPoLKYyxhs-h0De0riSkFb7+phn91Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Feb 21, 2018 at 04:41:05PM +0100, Jason A. Donenfeld wrote:
>Fixes: 41c87425a1ac ("netlink: do not set cb_running if dump's start() errs")
I think you Would better to resend it.

Bo,
