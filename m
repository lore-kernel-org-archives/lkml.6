Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEBMzm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:55:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39553 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeEBMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:55:39 -0400
X-Google-Smtp-Source: AB8JxZqWXgjaRUP/fJz9ZaU0eRuyaZ+XnXanJW0a9bkJ8tBIdQ4ie96PXV4ALOI07D7OjwBFdsifeQUrAw5CjRqjUog=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 2 May 2018 18:25:37 +0530
Message-ID: <CAHhAz+jyXx=OWYdBUm8syOjB7D=kzF+YddSTNWm8-y4S9Qd5Rw@mail.gmail.com>
Subject: linux-sound: timestamps for audio frames
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please keep me in CC as I'm not subscribed to the list]

Hi All,

>From sound driver, I am wondering if we could get the timestamps when
It receives for example the first and last audio frames.


Is there any way we can extract or expose that information to user mode?


-- 
Thanks,
Sekhar
