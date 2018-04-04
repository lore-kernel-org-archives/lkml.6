Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeDDCjl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:39:41 -0400
Received: from elephants.elehost.com ([216.66.27.132]:42936 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754850AbeDDCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:39:39 -0400
From: "Randall S. Becker" <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.17.0
Date: Tue, 3 Apr 2018 22:39:29 -0400
Message-ID: <025601d3cbbe$2b5a9da0$820fd8e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhLuUQLx28uJBqsgyhh0QfTRDAYKTVHiJw
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 2, 2018 3:34 PM, Junio C Hamano wrote:
> Subject: [ANNOUNCE] Git v2.17.0
> 
> The latest feature release Git v2.17.0 is now available at the usual places.  It is
> comprised of 516 non-merge commits since v2.16.0, contributed by 71
> people, 20 of which are new faces.

The NonStop platform variant's regression suite (after applying are now very small set of platform mods) had the usual failures in t1308:23, t1404:52, and 4 in t9001. This is equivalent to the same breaks since 2.8.5 through 2.16.2. We should be installing in production tomorrow.

Thanks for everyone's hard work.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.
