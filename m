Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEDRiZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:38:25 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:46688 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeEDRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:38:23 -0400
X-Google-Smtp-Source: AB8JxZqit8xIe9KfpKVwDS1sZw00A4/3BL8pkZcPUUDhfsaMgdZXtx6VglvgcoK6T9IVN4mNxkIe7LHhWB3WYcFokNE=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 4 May 2018 23:08:21 +0530
Message-ID: <CAHhAz+iOotCJCnBhUUpw1v+3mB5BvU1sd8BnRzVv09J9y9bTjw@mail.gmail.com>
Subject: serial: uart_port->type
To: kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44HcTHr021059

Hi All,

For the uart_port structure’s “type”, I see the permitted types are
none, 8250, 16450, 16550, 16550A, 16650, 16650V2, 16654, 16750, 16850,
16950, and 16954 etc.

For FPGA based UART hardware(it has 512 bytes FIFO and supports up to
4Mbps speed) what should be the ‘type’ value?


-- 
Thanks,
Sekhar
