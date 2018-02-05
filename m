Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeBELWX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:22:23 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36935 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeBELWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:22:16 -0500
X-Google-Smtp-Source: AH8x226zcP/sek+jQxYdEtaF7KNAFVZxThVFdieRth3TK1gIqDrist8PPEw3OXFdnwlj2/aLkgYeVA==
Date: Mon, 5 Feb 2018 12:22:12 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, jani.nikula@linux.intel.com
Subject: Re: [PATCH v2] Documentation/process: kernel maintainer PGP guide
Message-ID: <20180205112211.vloh5l57fnjzzzxm@ltop.local>
References: <20180130184917.GA32095@gmail.com>
 <20180201144233.GA19712@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201144233.GA19712@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 09:42:33AM -0500, Konstantin Ryabitsev wrote:
> +
> +    $ git --list-key torvalds@kernel.org

Small typo here: you meant 'gpg --list-key' instead of 'git ...'


Regards,
-- Luc Van Oostenryck
