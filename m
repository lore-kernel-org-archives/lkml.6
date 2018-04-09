Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeDIRpw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:45:52 -0400
Received: from listserv2.niif.hu ([193.225.14.155]:33459 "EHLO
        listserv2.niif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeDIRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:45:51 -0400
From: wferi@niif.hu (Ferenc =?utf-8?Q?W=C3=A1gner?=)
To: linux-kernel@vger.kernel.org
Cc: wferi@niif.hu
Subject: Re: What's the priority of the idle task?
References: <20180404143735.GA23925@aton>
Mail-Followup-To: Ferenc =?utf-8?Q?W=C3=A1gner?= <wferi@niif.hu>,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Apr 2018 19:45:43 +0200
In-Reply-To: <20180404143735.GA23925@aton> (Till Smejkal's message of "Wed, 4
        Apr 2018 16:37:35 +0200")
Message-ID: <876050ff3s.fsf@lant.ki.iif.hu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till Smejkal <till.smejkal@googlemail.com> writes:

> [...] Hence, the idle task is not managed by CFS and accordingly
> doesn't have any nice value or priority (or at least it is not
> important nowadays).

Thanks for your very to-the-point answer!  I'm still disturbed by the
above statement, though, because not being managed by CFS does not imply
having no meaningful priority: RT tasks seem to have one.  Did you mean
to imply this?  Guessing not, I added your answer with code illustrations 
as https://unix.stackexchange.com/a/436575/119808.
-- 
Regards,
Feri
