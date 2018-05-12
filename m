Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeELQKX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 12:10:23 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34089 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeELQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 12:10:21 -0400
X-Google-Smtp-Source: AB8JxZpLycfUIFKnSbCFkN+EoYEYaTe3sZN4FiO765r1M6ynISQfJwPkEPP2hwcqkfsSlmfGTZq+yw==
Subject: Re: [RFC: Coding Style] Best way to split a long function declaration
 with modifiers
To: Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
References: <4fdc0980-d0af-3a02-02e7-0beed8ba05e2@gmail.com>
 <2d0127b079b8c9547519ee8c38a42042ad946d50.camel@perches.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <79c58d1a-5d30-e3be-b7ad-c561f81d7b16@gmail.com>
Date: Sat, 12 May 2018 19:10:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2d0127b079b8c9547519ee8c38a42042ad946d50.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/18 18:41, Joe Perches wrote:

>> I personally like more the former, not to mention that it uses also one
>> line less, but it seems less common in the sources.
>> The coding style references do not seem to say anything explicit about
>> which style to prefer.

thank you, I could provide a patch to the docs for this case, if it's 
not considered too much of a corner case.

--
igor
