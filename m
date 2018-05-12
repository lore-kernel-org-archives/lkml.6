Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeELPT0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 11:19:26 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41049 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeELPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 11:19:25 -0400
X-Google-Smtp-Source: AB8JxZqAK5vci4mzOGnWFE3jvbReVHuJ7IlvEWNhkwqUSJSv89jcdgJP/csEshw3+JpSjk+FmR3PPQ==
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: [RFC: Coding Style] Best way to split a long function declaration
 with modifiers
Message-ID: <4fdc0980-d0af-3a02-02e7-0beed8ba05e2@gmail.com>
Date: Sat, 12 May 2018 18:19:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have been wondering if it's ok to break a long (function declaration) 
line in the following way:

static __always_inline
struct foo_bar *__get_foo_bar(type1 parm1, type2 parm2, type3 parm3)


instead of:

static __always_inline struct foo_bar *__get_foo_bar(type1 parm1,
						     type2 parm2,
						     type3 parm3)


I personally like more the former, not to mention that it uses also one 
line less, but it seems less common in the sources.
The coding style references do not seem to say anything explicit about 
which style to prefer.

And not all the code in the kernel is of the same quality, so finding an 
example doesn't automatically mean that it's a good practice to follow :-)

--
thanks, igor
