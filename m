Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeBIWYm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:24:42 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:58435 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752724AbeBIWYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:24:41 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180202145434.100626-1-arnd@arndb.de>
Cc: "Nicolas Pitre" <nico@linaro.org>, "Andi Kleen" <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>
References: <20180202145434.100626-1-arnd@arndb.de>
Message-ID: <151821507347.9954.4785393248908071074@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH 0/3] x86 bugfixes for LTO
Date: Fri, 09 Feb 2018 22:24:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-02-02 14:54:28)
> Here are three bugfixes for x86 that I needed to get LTO-enabled
> kernels to build reliably. I'm not sure abouto that first one
> though.

Is there a howto on how to build LTO kernels? I tried Andi's lto-415-2
branch, but linking fails with lots of arcane PIE-vs-PIC errors. We are
wanting to investigate how we can use LTO to reduce our (i915.ko) module
size (by e.g. supporting a subset of chipsets).
-Chris
