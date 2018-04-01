Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeDAUIa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:08:30 -0400
Received: from h2.hallyn.com ([78.46.35.8]:57548 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbeDAUI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:08:29 -0400
Date: Sun, 1 Apr 2018 15:08:27 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
Cc: jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 0/2] WhiteEgret LSM module
Message-ID: <20180401200827.GA28101@mail.hallyn.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masanobu Koike (masanobu2.koike@toshiba.co.jp):
...
> Assumptions and ToDos
> 
> At this stage, WhiteEgret assumes the following.
> Relaxing these assumptions are future works.
> - Root is not compromised. And using a whitelist and a WEUA
> requires root privilege.
> - WEUA is reliable.
> - It is allowed for scripting languages, e.g., Perl or Python,
> to read arbitrary scripts and to execute them.

Hi,

regardling the last one, do you have a plan for handling it?
