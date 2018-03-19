Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeCSJTn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:19:43 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35735 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933006AbeCSJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:17:47 -0400
X-Google-Smtp-Source: AG47ELsAgesszY8RLgkKPksTWnHOL+NSngcGpuLnczc9MINpVZnr+0fKKzz/24AtbMFikR80wOlqSg==
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc: Netdev list <netdev@vger.kernel.org>
References: <20180318104023.GA10392@amd>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
Date: Mon, 19 Mar 2018 05:17:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <20180318104023.GA10392@amd>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
> With recent linux-next, after resume networkmanager often claims that
> "network is disabled". Sometimes suspend/resume clears that.
>
> Any ideas? Does it work for you?
> 									Pavel
Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.

Woody
