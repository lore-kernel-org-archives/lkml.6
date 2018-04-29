Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeD2UUk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 16:20:40 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:45452 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeD2UUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 16:20:37 -0400
X-Google-Smtp-Source: AB8JxZrh/D/nS0+bA4KyxQn2oFLqfPxG7WBRqDqa31G4y3E8dZgP4Kuz9N7sLQzaDmJT7NdUcjtFZA==
Date: Sun, 29 Apr 2018 13:20:33 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
References: <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429184101.GA31156@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 08:41:01PM +0200, Pavel Machek wrote:
> Umm. No. https://www.youtube.com/watch?v=xneBjc8z0DE

Okay, but /dev/urandom isn't a solution to this problem because it isn't usable
until crng init is complete, so it suffers from the same init lag as
/dev/random.

Sultan
