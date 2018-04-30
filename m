Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755161AbeD3VUN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:20:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45344 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbeD3VUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:20:11 -0400
X-Google-Smtp-Source: AB8JxZr/dnhkiJd0boKf3D3lh/o4GYMioN4Trm5AI8UApIkmt5E+p3sxE/rAHJeC4G39D2hJDVlAKQ==
Date: Mon, 30 Apr 2018 14:20:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Engraf <david.engraf@sysgo.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: serio - add writing multiple bytes at once
Message-ID: <20180430212007.GC54182@dtor-ws>
References: <20180430090324.30845-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430090324.30845-1-david.engraf@sysgo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Apr 30, 2018 at 11:03:24AM +0200, David Engraf wrote:
> The current version only supports forwarding a single byte to the tty
> layer.
> 
> This patch adds serio_write_length() to allow a serport driver writing
> multiple bytes at once. The patch also includes a fallback to
> serio_write_length() when a driver did not register a single byte function.

Without users I do not see point for this API.

Thanks.

-- 
Dmitry
