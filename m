Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbeEWJaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:30:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754411AbeEWJaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:30:00 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org (open list:Hyper-V CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] tools: hv: update lsvmbus to be compatible with python3
References: <20180522075417.13691-1-olaf@aepfle.de>
Date: Wed, 23 May 2018 11:29:56 +0200
In-Reply-To: <20180522075417.13691-1-olaf@aepfle.de> (Olaf Hering's message of
        "Tue, 22 May 2018 09:54:16 +0200")
Message-ID: <871se2en3f.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> Python3 changed the way how 'print' works.
> Adjust the code to a syntax that is understood by python2 and python3.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

What are the odds that we decide to send the same patch on the same day?
:-)

http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-May/121144.html

-- 
  Vitaly
