Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeA3TAd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:00:33 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:39673 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeA3TAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:00:31 -0500
X-Google-Smtp-Source: AH8x226qgCDwT/Qmj41kfOUS0hIeG7cSzcMBucolj2JcyHKu0ER5qr47JEnS5XwA+h+2VTk8J9WrCZ6UE5pBfPm91IA=
MIME-Version: 1.0
In-Reply-To: <CACdnJuuGdM-9ZUNybHuQzEhtb2wUxYktPt+Fu9kyjzKdGfnOTA@mail.gmail.com>
References: <20170804180751.14896-1-mjg59@google.com> <20170810204328.kk4lbj4hvednmofw@redbean>
 <CACdnJusrO0rThxt0ikapFVWtJZVaiYj8AJ_oFOczskRKS4fVpA@mail.gmail.com>
 <20170829175647.ej5fqszss2mbpc5i@redbean> <CACdnJutWdHi5YOG1Mn0vZwTmZyQHyyABeZ0caNn2rJCYehCGhg@mail.gmail.com>
 <1504044122.4448.24.camel@decadent.org.uk> <CACdnJuuGdM-9ZUNybHuQzEhtb2wUxYktPt+Fu9kyjzKdGfnOTA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 30 Jan 2018 11:00:30 -0800
Message-ID: <CACdnJuuw9Sav7G=mMm4LnL2RBYABJvQuP5PkHexoMndxRmw1hw@mail.gmail.com>
Subject: Re: Allow automatic kernel taint on unsigned module load to be disabled
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2017 at 11:27 AM, Matthew Garrett <mjg59@google.com> wrote:
> Hi Jessica,
>
> It seems that there's distribution interest in this - any feedback?

Hi,

I think we'd still benefit from this being available, so just checking
whether you had any further feelings on it.
