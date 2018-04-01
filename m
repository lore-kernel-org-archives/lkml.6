Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDAVcI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 17:32:08 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45026 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753976AbeDAVcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 17:32:07 -0400
X-Google-Smtp-Source: AIpwx4/gIqWjt8bFG4eOydIM71Km/jiPZtHe34BD4VUco+c3XyyP24/f5XrWapj/a1btzXZ4mEP1ig==
Date: Mon, 2 Apr 2018 00:32:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <20180401213204.GB25507@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We could, for example, wrap things like userspace pointers, __be numbers,
> ioport addresses and control access to them that way, but I don't know that it
> gains a whole load that sparse doesn't give us.

The problem with sparse is that it is not mandatory part of a build
process. And it spams lot ATM.
