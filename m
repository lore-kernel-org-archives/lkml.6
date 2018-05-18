Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeERQoo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:44:44 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:45243 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeERQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:44:43 -0400
X-Google-Smtp-Source: AB8JxZrZXMw0JQ5Kh2usiDcHcfq+nz9JkvFebJHS8G8Mv7m1m99WmNgY4Xwh6x/waHfLettbLBe7FQohQwFIEKEeLoY=
MIME-Version: 1.0
From: Simon Que <sque@chromium.org>
Date: Fri, 18 May 2018 12:44:31 -0400
Message-ID: <CANV8Hs3Rc1q_Qcp05jGfuVwqTFg0c9UhNebk24UYGkkGiHpPRA@mail.gmail.com>
Subject: Should new code have forward declarations of static functions or not?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it preferred to have forward declarations of static funcs, or to omit
them altogether?

I know that different files in kernel code follow one style or the other.
Just wondering if there's a preferred style for new code.

Simon
