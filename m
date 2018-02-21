Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966087AbeBUPlK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:41:10 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:37297 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938005AbeBUPlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:41:09 -0500
X-Google-Smtp-Source: AH8x2248GHAAK8ffLSC+2xaePmL+ByIjW3ljSssIUZasaL9rFWXOHxIxbz6k5R9H6Df8X6gIQ1+7iggu341/iAoPvnU=
MIME-Version: 1.0
In-Reply-To: <1519225917.55655.42.camel@gmail.com>
References: <20180221034159.14685-1-Jason@zx2c4.com> <1519192048.55655.35.camel@gmail.com>
 <CAHmME9px8Bwjz-D0dbSgm3vRPiEaBavEaG=2bGWC0_L3api5rw@mail.gmail.com> <1519225917.55655.42.camel@gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2018 16:41:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9pHTfryRwr7rA36KPoLKYyxhs-h0De0riSkFb7+phn91Q@mail.gmail.com>
Message-ID: <CAHmME9pHTfryRwr7rA36KPoLKYyxhs-h0De0riSkFb7+phn91Q@mail.gmail.com>
Subject: Re: [PATCH] netlink: put module reference if dump start fails
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 41c87425a1ac ("netlink: do not set cb_running if dump's start() errs")
