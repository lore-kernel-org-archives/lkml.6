Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeBAOpe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:45:34 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33470 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBAOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:45:32 -0500
X-Google-Smtp-Source: AH8x2269JHmyh0zk9753uZ+WHlUktWPmxHqxhrmrXi/vaL5ChX4Y6OaS4EFAjTmQ0efBVrXcx542nQ==
Date: Thu, 1 Feb 2018 09:45:28 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: kernel maintainer PGP guide
Message-ID: <20180201144528.zfbinlt2hhsj34j2@gmail.com>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20180130184917.GA32095@gmail.com>
 <87bmhajy30.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87bmhajy30.fsf@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 09:18:11AM +0200, Jani Nikula wrote:
>Just one nit, I think it would be better to move the Maintainer: bit
>from the end near the top as a reStructuredText field list. See 'git
>grep :Author:' under Documentation for examples. Could even add a
>MAINTAINERS entry to improve your chances of being Cc'd on changes.

Thank you for the feedback -- I've submitted a v2 with that change (and 
a few bugfixes that resulted from md->rst conversion).

I'm not sure one doc file is good enough reason to be put into 
MAINTAINERS, even if the perk is that I get pre-approved for a 
kernel.org account. ;)

Best regards,
-K
