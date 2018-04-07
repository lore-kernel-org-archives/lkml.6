Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeDGWFo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 18:05:44 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:56298 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeDGWFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 18:05:42 -0400
X-Google-Smtp-Source: AIpwx4/BC50s+S+zRflxP6SVhpSQRTHUu6aFm4W3UrT3tdPVyJIhiX5wFhUkoAuwxMzrDI5BOoJTJTsGw1RV2BBDsUA=
MIME-Version: 1.0
In-Reply-To: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
References: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 15:05:41 -0700
X-Google-Sender-Auth: -nimAN58PQqzINyfu5QKgysOzZ0
Message-ID: <CA+55aFzvWoVQhgrY8qtgPE5j=M+zMeJwJHdV=Mz9q0NE1JNbXQ@mail.gmail.com>
Subject: Re: [PATCH v2] add -Wpointer-arith sparse flag to toggle sizeof(void) warnings
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, looks sane.

             Linus
