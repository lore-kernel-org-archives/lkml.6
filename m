Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeBDJM1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 04:12:27 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35113 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBDJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 04:12:17 -0500
X-Google-Smtp-Source: AH8x225JNUixYu6PQypUTYHxq9EWd4f0k1IGgyYxQz0Eo/qZSCeIJ721nAfpHs+xF6IN3LibczPIxLbcMF6WvtmVrLs=
MIME-Version: 1.0
In-Reply-To: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 4 Feb 2018 10:12:16 +0100
X-Google-Sender-Auth: ZMB9Vcc5VsxKVlSZEXGYsqfTe1w
Message-ID: <CAJZ5v0gj6GT=kuQvTZifktuK887_o98t4voUUK0i_90Hnw0Tpg@mail.gmail.com>
Subject: Re: [PATCH] Revert "cpuidle: Make drivers initialize polling state"
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w149CV1V028409

On Mon, Jan 22, 2018 at 5:27 PM, Ville Syrjala
<ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>
> This reverts commit 1b39e3f813b4685c7a30ae964d5529a1b0e3a286.
>
> Makes my P3 machine oops somewhere in cpuidle. I suspect
> CONFIG_ACPI=n may have something to do with this.

And if you don't do CONFIG_ACPI=n, does it still oops?

Anyway, there are later changes depending on this one, so reverting it
won't work in general.

Let me look deeper at this.

Thanks,
Rafael
