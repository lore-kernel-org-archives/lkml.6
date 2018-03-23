Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeCWMqX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:46:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39950 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeCWMqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:46:22 -0400
Date: Fri, 23 Mar 2018 13:46:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next 0/2] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180323124615.GB5145@lunn.ch>
References: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521793455.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 4. Crashdd exposes the buffer as a file via
> /sys/kernel/crashdd/<driver>/<dump_file>.

Hi Rahul

You should add something to Documentation/ABI/. All sysfs files need
to be documented.

   Andrew
