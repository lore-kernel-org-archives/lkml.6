Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbeBVQTk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:19:40 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:51076 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933222AbeBVQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:19:33 -0500
X-Google-Smtp-Source: AH8x224OSFNyQA46F5CoW7ZLzW+Hvg6lITJ6tWIKhJEjo7OkQrYKrmkY64qEHChbPO76qjECGxrAu2kOsxtcz3vnpyo=
MIME-Version: 1.0
In-Reply-To: <20180222072459.GA9891@saruman>
References: <20180221233825.10024-1-jhogan@kernel.org> <20180221233825.10024-2-jhogan@kernel.org>
 <ea057277-fc48-3961-681d-385023741cdb@roeck-us.net> <20180222072459.GA9891@saruman>
From: Graham Whaley <graham.whaley@gmail.com>
Date: Thu, 22 Feb 2018 16:19:31 +0000
Message-ID: <CAF9eJumRb0voffQXqWg5goO8=1KNpivrefLtLCUUh_4k6g7+JQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] metag: Remove arch/metag/
To: James Hogan <jhogan@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-metag@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> > So lets call it a day and drop the Meta architecture port from the
>> > kernel. RIP Meta.

Oh, and James, I meant to ask/note - I guess that just leaves parisc
using STACK_GROWSUP... shame we could not ditch that as well then eh?

 Graham
