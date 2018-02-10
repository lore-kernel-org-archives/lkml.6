Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeBJBnx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:43:53 -0500
Received: from mout.perfora.net ([74.208.4.194]:32773 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeBJBnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:43:47 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] ARM: dts: tegra: apalis-tk1: updates incl. v1.2 hardware support
Date: Sat, 10 Feb 2018 02:38:00 +0100
Message-Id: <20180210013806.28496-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:aedpp3MPnZWbP62PgYymoiLRle8d2KGU75K9oqgrP1miNh1ZuUS
 4EekXuqbC5g9wmn0hjfZXYQFBM10Kr1Mcogd5PywvbtMggQ7/ZD71WzWjfzWmUSZ6b7JBYO
 l4Wi/NCoBbVGNA4Yb8EtZwOcqciOTQwc/LmO3fhHZaLmw3PWCIvzqO5YCwChW5BHnSYUAor
 FOTRrLEG0SvjClUEC0/gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cqvbbp9z+a8=:e5zrrckz6At79+3E+s/SPF
 lTa0V2D7hmUH5ocTTmbSAwuOqEhzt+YGO89aKzn1xhg4PQEUWX3SnVvmoxl/obHv/QEZ7YB05
 IEh7Cj+Uc3iwRwXqxjbJQHzm6jxlyOGwovQAry4uzLZTbGCgel/BB3RADTc0cEFpv7OdPpbtm
 k/U69DwBbX9jrM+XYP845CMkQ6WXWjQvm1dRTMLM3AzgKcQJfglDDdCkZJ9+MatO25a+ThzQ4
 7cImaLmvzDJt7yibLPmrVvxLwx/bTvvH/Am9TIPvO9yqHeP/sAEFsZgQeqn1toX4wzf++Q7Ni
 p8zU+SSt7PcUS09ZwYbXeLobDMRWhD3lfTH9zYnxInWM40zoTmZ5uooV/8mTX6XKxttl0ly8m
 IGi2x3rwQJS/TBbchFSrZmHXb8TtrgosBeuB0KC/LjB4nMLNudLXU+Y/S0M/VsNJX7IfyuZwA
 n/ooahRv5mZiDT0FIj+9GIZGZZXnP7SFVrQ0CCDUp103QGpwDVpk8yCcRFWDmKrkBSDoUJWXA
 rsX7VPN29HZwdsGMNqogXVm+vFTI6dTGdOrf9m3yMPaGPHiRJvkzfgPU1jjmfzes1UCEwnhg9
 lAh/TtAeXFqP95THJdMhILnw+13s2yKdYDT25VwBgtZZ92DLvd56w5311P1NJcy1mTObc9Gbs
 wk4q8hPpLMxwkQ9vmkhYelXeTskr/hRl26pIO+t3OBek3/8vXqKqQSFZWtD7R9JJGvRgYxWDl
 sBtClHO5XKLnHalAQys5EXKrVQ4E7WmfARazFg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series sets critical trips, activates PWM pin muxing for PWM3,
adds a missing AS3722 GPIO0 configuration, adds a hog group for
Ethernet, PCIe, reset GPIOs, updates the copyright period, removes
spurious newlines and adds support for the V1.2 hardware revision of
the Toradex Apalis TK1 system on module.


Marcel Ziswiler (6):
  arm: tegra: apalis-tk1: set critical trips
  ARM: dts: tegra: apalis-tk1: activate pwm pin muxing for pwm3
  ARM: dts: tegra: apalis-tk1: add missing as3722 gpio0 configuration
  ARM: dts: tegra: apalis-tk1: hog group for ethernet, pcie, reset gpios
  ARM: dts: tegra: apalis-tk1: copyright period, spurious newlines
  ARM: dts: tegra: apalis-tk1: support v1.2 hardware revision

 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |   16 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  250 +++
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 2052 +++++++++++++++++++++++
 arch/arm/boot/dts/tegra124-apalis.dtsi          |   70 +-
 5 files changed, 2344 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi

-- 
2.14.3
