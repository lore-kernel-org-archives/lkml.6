Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCNRl6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:41:58 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46148 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:41:56 -0400
X-Google-Smtp-Source: AG47ELt0a/y8BMmOWvYjugrM0N7q7zY8z1KZ2SJCwXlz3PRaBneecsJIYau6Et6iBCQCsXUG72zh7g==
Date: Wed, 14 Mar 2018 20:41:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Message-ID: <20180314174150.GA2068@avx2>
References: <20180314143755.1508262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314143755.1508262-1-arnd@arndb.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 03:37:37PM +0100, Arnd Bergmann wrote:
> Hardwall is a tile specific feature, and with the removal of the
> tile architecture, this has become dead code, so let's remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

ACK

Although it should go via tile tree for "atomicity".
