Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeCUPRG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:17:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:50008 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeCUPRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:17:03 -0400
Date: Wed, 21 Mar 2018 09:17:01 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Gary R Hook <gary.hook@amd.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] Documentation/CodingStyle: Add an example for braces
Message-ID: <20180321091701.7d56445d@lwn.net>
In-Reply-To: <152114372879.3142.8833111074324091904.stgit@taos>
References: <152114372879.3142.8833111074324091904.stgit@taos>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 15:04:02 -0500
Gary R Hook <gary.hook@amd.com> wrote:

> +Do use braces when a body is more complex than a single simple statement:
> +
> +.. code-block:: c
> +
> +	if (condition) {
> +		if (another_condition)
> +			do_something();
> +	}

Somebody is sure to complain at some point that this should really be:

	if (condition && another_condition)
		do_something();

To head that off, I think I'll apply your first version instead, sorry
Jani.

In general I'm pretty reluctant to apply coding-style patches for the
simple reason that I sure don't want to be the arbitrator of proper kernel
style.  This one seems to fit well within the accepted norms, though.

Thanks,

jon
