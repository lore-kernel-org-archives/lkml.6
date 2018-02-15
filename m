Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbeBOKIB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:08:01 -0500
Received: from parrot.pmhahn.de ([88.198.50.102]:41444 "EHLO parrot.pmhahn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755240AbeBOKH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:07:59 -0500
Subject: Re: [PATCH] namei: fix hardlink speeling error
To: Richard Guy Briggs <rgb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, Paul Moore <paul@paul-moore.com>
References: <68d4b8c4ad6b85d4336f2a2893e3ea04ffdc7794.1518661649.git.rgb@redhat.com>
From: Philipp Hahn <pmhahn@pmhahn.de>
Message-ID: <4ed8e95b-0aa8-ae26-7ec4-e01235583e8f@pmhahn.de>
Date: Thu, 15 Feb 2018 10:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68d4b8c4ad6b85d4336f2a2893e3ea04ffdc7794.1518661649.git.rgb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 15.02.2018 um 03:28 schrieb Richard Guy Briggs:
> Fix handlink to hardlink.

and introduce a new sp*el*ling error in the subject line ;-)

Philipp
