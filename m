Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeAaJgd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:36:33 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:42258 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbeAaJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:36:28 -0500
X-Google-Smtp-Source: AH8x226FMJgBI8UamjbwE8wh+jc0VISwr99uPQ9qvptuV3ashabgJHBfob8FBJ9r9RzsvuyXin3WBoopjManPI1JGAo=
MIME-Version: 1.0
X-Originating-IP: [193.43.158.243]
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jan 2018 04:36:26 -0500
Message-ID: <CAHC9VhTV-5=wk6jSkK7xAvg8aGzkO_RZ21zo_zVK-Br+rB-8SA@mail.gmail.com>
Subject: No audit patches for v4.16
To: linux-audit@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

As the audit/next branch is empty, there isn't going to be a pull
request for the 4.16 merge window.  Because of this, I'm going to take
the opportunity to go ahead and rebase audit/next to v4.15; hopefully
this doesn't mess up any work in progress, if it does let me know and
we can work something out.

-- 
paul moore
www.paul-moore.com
