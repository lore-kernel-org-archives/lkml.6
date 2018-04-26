Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeDZFGD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:06:03 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:43767 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeDZFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:05:59 -0400
X-Google-Smtp-Source: AIpwx48U8JFLkQ+IPurZoqUzQG2x4hL8UpbvfC1wYljAutHHfosBupLNZ227tcjo6rz/G2csnprrrQ==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
From: Sultan Alsawaf <sultanxda@gmail.com>
Message-ID: <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
Date: Wed, 25 Apr 2018 22:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426050056.GF18803@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the report!
>
> I assume since you're upgrading your own kernel, you must not be
> running Chrome OS on your Acer CB3-431 Chromebook (Edgar).  Are you
> running Chromium --- or some Linux distribution on it?
>
> Thanks,
>
> 					- Ted

Correct, I'm running Xubuntu 18.04 with my own kernel based off linux-stable.
